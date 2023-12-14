import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:osm_map/services/camera_service.dart';
import 'package:osm_map/services/geolocator_service.dart';
import 'package:osm_map/services/firebase_service.dart';
import 'package:flutter_osm_interface/src/types/geo_point.dart' as osm;

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final CameraService _cameraService = CameraService();
  final GeolocatorService _geolocatorService = GeolocatorService();
  final FirebaseService _firebaseService = FirebaseService();
  MapController? _mapController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    await _cameraService.initializeCamera();
    if (!mounted) return;
    setState(() {}); // カメラ初期化後にUIを更新
  }

  @override
  void dispose() {
    _cameraService.controller?.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    final picture = await _cameraService.takePicture();
    if (picture != null) {
      final position = await _geolocatorService.getCurrentLocation();
      await _firebaseService.saveLocation(position);
      _mapController?.addMarker(
        osm.GeoPoint(latitude: position.latitude, longitude: position.longitude),
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cameraService.controller?.value.isInitialized != true) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_cameraService.controller!), // nullチェックを確実に行う
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FloatingActionButton(
              onPressed: _takePicture,
              child: Icon(Icons.camera),
            ),
          ),
        ],
      ),
    );
  }
}


