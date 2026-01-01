import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class RinjaniMapWidget extends StatefulWidget {
  const RinjaniMapWidget({super.key});

  @override
  State<RinjaniMapWidget> createState() => _RinjaniMapWidgetState();
}

class _RinjaniMapWidgetState extends State<RinjaniMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();

  // Lokasi Tujuan (Gunung Rinjani - Senaru)
  static const LatLng _destination = LatLng(-8.3249, 116.4069);

  // Lokasi User (Akan diisi otomatis)
  LatLng? _currentPosition;

  // Data Marker & Rute
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  // API Key (Gunakan key yang sama dengan di AndroidManifest)
  String googleApiKey = "AIzaSyCxmPiVRwyPQwuo1gxi4SpWeCa0xT359Rg";

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  // 1. Ambil Lokasi User
  Future<void> _getUserLocation() async {
    // Cek Izin Lokasi
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    // Ambil Koordinat
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);

      // Tambahkan Marker
      _markers.add(
        Marker(
          markerId: const MarkerId("user"),
          position: _currentPosition!,
          infoWindow: const InfoWindow(title: "Lokasi Saya"),
        ),
      );
      _markers.add(
        const Marker(
          markerId: MarkerId("dest"),
          position: _destination,
          infoWindow: InfoWindow(title: "Gunung Rinjani"),
        ),
      );
    });

    // Buat Rute setelah lokasi didapat
    _getRoute();
  }

  // 2. Gambar Rute (Polyline)
  Future<void> _getRoute() async {
    if (_currentPosition == null) return;

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: googleApiKey,
      request: PolylineRequest(
        origin: PointLatLng(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        ),
        destination: PointLatLng(_destination.latitude, _destination.longitude),
        mode: TravelMode.driving,
      ),
    );
    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = [];
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: Colors.blue[800]!,
            width: 5,
          ),
        );
      });

      // Zoom Camera agar muat semua marker
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          _boundsFromLatLngList([_currentPosition!, _destination]),
          50,
        ),
      );
    }
  }

  // Helper untuk Zoom otomatis
  LatLngBounds _boundsFromLatLngList(List<LatLng> list) {
    double? x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(
      northeast: LatLng(x1!, y1!),
      southwest: LatLng(x0!, y0!),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return const SizedBox(
        height: 250,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _currentPosition!,
            zoom: 14,
          ),
          markers: _markers,
          polylines: _polylines,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
