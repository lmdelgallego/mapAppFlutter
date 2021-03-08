import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  @override
  _FullScreenMapState createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  MapboxMapController mapController;
  final center = LatLng(4.7051101, -74.0598821);
  final String styleMapDark =
      'mapbox://styles/alucardluis/ckll2a8yi2gf617p8otkjzl4z';
  final String styleMapNormal =
      'mapbox://styles/alucardluis/ckll2cl5p2ghb17p8cw1s1p9z';
  String selectedStyle =
      'mapbox://styles/alucardluis/ckll2cl5p2ghb17p8cw1s1p9z';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/custom-icon.png");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFLotantes(),
    );
  }

  Column botonesFLotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () {
            mapController.animateCamera(CameraUpdate.newLatLng(center));
          },
          child: Icon(Icons.gps_fixed_sharp),
        ),
        SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            mapController.addSymbol(
              SymbolOptions(
                geometry: center,
                // iconSize: 2,
                iconImage: 'networkImage',
                textField: 'Mi Casa',
                textOffset: Offset(0, 2),
              ),
            );
          },
          child: Icon(Icons.pin_drop_outlined),
        ),
        SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomIn());
          },
          child: Icon(Icons.zoom_in),
        ),
        SizedBox(height: 8),
        FloatingActionButton(
          onPressed: () {
            mapController.animateCamera(CameraUpdate.zoomOut());
          },
          child: Icon(Icons.zoom_out),
        ),
        SizedBox(height: 8),
        FloatingActionButton(
          child: Icon(Icons.add_to_home_screen),
          onPressed: () {
            if (selectedStyle == styleMapDark) {
              selectedStyle = styleMapNormal;
            } else {
              selectedStyle = styleMapDark;
            }
            _onStyleLoaded();
            setState(() {});
          },
        )
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      accessToken:
          'pk.eyJ1IjoiYWx1Y2FyZGx1aXMiLCJhIjoiY2tsa3VvODVpMDUzYzJubno0aHJncTE1byJ9.-uiruJNS4eYIeX1Mv-XTUw',
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 18,
      ),
      onStyleLoadedCallback: onStyleLoadedCallback,
    );
  }

  void onStyleLoadedCallback() {}
}
