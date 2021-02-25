import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken:
            'pk.eyJ1IjoiYWx1Y2FyZGx1aXMiLCJhIjoiY2tsa3VvODVpMDUzYzJubno0aHJncTE1byJ9.-uiruJNS4eYIeX1Mv-XTUw',
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(4.7051101, -74.0598821),
          zoom: 18,
        ),
        onStyleLoadedCallback: onStyleLoadedCallback,
      ),
    );
  }

  void onStyleLoadedCallback() {}
}
