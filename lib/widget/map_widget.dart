import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // Lokasi default (Contoh: Monas)
  LatLng _currentPosition = const LatLng(-6.175392, 106.827153);
  // Lokasi Tujuan (Contoh: Gunung Rinjani / Sesuaikan dengan tujuan app Anda)
  final LatLng _destination = const LatLng(-8.4113, 116.4573);

  List<LatLng> _routePoints = [];
  final MapController _mapController = MapController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _determinePosition();
    await _getRouteOSRM(); // Panggil rute gratis
  }

  // 1. Fungsi Cek Lokasi User (Aman untuk Windows & HP)
  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Jika GPS mati, pakai lokasi default dulu biar gak crash
        setState(() => _isLoading = false);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoading = false);
          return;
        }
      }

      // Ambil lokasi
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );

      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
        });
      }
    } catch (e) {
      debugPrint("Error Lokasi: $e");
    }
  }

  // 2. Fungsi Ambil Rute GRATIS (OSRM) - Pengganti Google
  Future<void> _getRouteOSRM() async {
    // Format URL OSRM: (Longitude,Latitude) <-- Dibalik!
    final String url =
        'http://router.project-osrm.org/route/v1/driving/'
        '${_currentPosition.longitude},${_currentPosition.latitude};'
        '${_destination.longitude},${_destination.latitude}'
        '?overview=full&geometries=geojson';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final geometry = data['routes'][0]['geometry']['coordinates'] as List;

        // Konversi data JSON ke LatLng Flutter
        final List<LatLng> points =
            geometry.map((p) {
              return LatLng(p[1].toDouble(), p[0].toDouble());
            }).toList();

        if (mounted) {
          setState(() {
            _routePoints = points;
            _isLoading = false;
          });
          // Arahkan kamera supaya rute terlihat semua
          // (Opsional, bisa manual)
        }
      }
    } catch (e) {
      debugPrint("Gagal ambil rute OSRM: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.travel_app',
              ),
              // Garis Rute (Biru)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: Colors.blue,
                    strokeWidth: 5.0,
                  ),
                ],
              ),
              // Marker User & Tujuan
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 40,
                    ),
                  ),
                  Marker(
                    point: _destination,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (_isLoading)
            const Center(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Memuat Rute..."),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
