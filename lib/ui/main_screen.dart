import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowSimpleMap extends StatefulWidget {
  const ShowSimpleMap({Key? key}) : super(key: key);

  @override
  _ShowSimpleMapState createState() => _ShowSimpleMapState();
}

class _ShowSimpleMapState extends State<ShowSimpleMap> {
  static LatLng _centrer = LatLng(45.5426283, -122.7944832);
  static LatLng _anotherrLocation = LatLng(45.533285, -122.6128007);
  late GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: GoogleMap(
        markers: {portLandMarkerTwo, portLandMarker},
        mapType: MapType.terrain,
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(target: _centrer, zoom: 11.0),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: _goIntel, label: Text('Find Quake')),
    );
  }

  Marker portLandMarker = Marker(
    markerId: MarkerId('PortLand'),
    position: _centrer,
    infoWindow: InfoWindow(title: 'PortLand', snippet: 'This is a great town'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
  );

  
  static LatLng _intelPosition=LatLng(45.5418324, -122.917043);
  static final CameraPosition intelPosition=CameraPosition(target: _intelPosition,zoom: 15.78,bearing: 191.789,tilt: 34.89);
  Future<void>  _goIntel()async{
    final GoogleMapController controller=await mapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(intelPosition));
  }


  Marker portLandMarkerTwo = Marker(
    markerId: MarkerId('PortLand Two'),
    position: _anotherrLocation,
    infoWindow:
        InfoWindow(title: 'PortLand 2', snippet: 'This is a great town two'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
  );
}

