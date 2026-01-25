import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapWidget extends StatefulWidget {
  // Tambahkan parameter isDark agar peta sinkron dengan tema aplikasi
  final bool isDark;
  const MapWidget({super.key, required this.isDark});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> with TickerProviderStateMixin {
  LatLng _currentPosition = const LatLng(-8.6433, 116.4554);
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
    await _getRouteOSRM();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) setState(() => _isLoading = false);
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) setState(() => _isLoading = false);
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _mapController.move(_currentPosition, 13.0);
        });
      }
    } catch (e) {
      debugPrint("Error Lokasi: $e");
    }
  }

  Future<void> _getRouteOSRM() async {
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
        final List<LatLng> points =
            geometry.map((p) {
              return LatLng(p[1].toDouble(), p[0].toDouble());
            }).toList();

        if (mounted) {
          setState(() {
            _routePoints = points;
            _isLoading = false;
          });
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
                userAgentPackageName: 'com.travel_app', // GANTI PAKE ID APP LU
                retinaMode: RetinaMode.isHighDensity(
                  context,
                ), // Sekalian hapus warning di terminal tadi
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: _routePoints,
                    color: Colors.blue,
                    strokeWidth: 5.0,
                  ),
                ],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.blue,
                      size: 35,
                    ),
                  ),
                  Marker(
                    point: _destination,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Tombol lokasi diletakkan di dalam Stack, bukan di dalam FlutterMap children
          Positioned(
            bottom: 10, // Naikkan sedikit agar tidak tertutup navbar
            right: 10,
            child: FloatingActionButton(
              heroTag: "btn_gps", // Unik agar tidak error saat navigasi
              onPressed: _determinePosition,
              backgroundColor: widget.isDark ? Colors.grey[850] : Colors.white,
              child: Icon(
                Icons.my_location,
                color: widget.isDark ? Colors.lightBlue : Colors.blue,
              ),
            ),
          ),

          if (_isLoading)
            Center(
              child: Card(
                color: widget.isDark ? Colors.grey : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    "Mencari Lokasi & Rute...",
                    style: TextStyle(
                      color: widget.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
