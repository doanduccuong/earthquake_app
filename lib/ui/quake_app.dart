import 'dart:async';

import 'package:earthquake_app/cubit/app_cubit.dart';
import 'package:earthquake_app/cubit/app_cutibt_state.dart';
import 'package:earthquake_app/model/quake_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class QuakesApp extends StatefulWidget {
  const QuakesApp({Key? key}) : super(key: key);

  @override
  _QuakesAppState createState() => _QuakesAppState();
}

class _QuakesAppState extends State<QuakesApp> {
  double _zoomValue = 5.0;
  final List<Marker> _markerList = [];
   static const LatLng _centrer = LatLng(45.5426283, -122.7944832);
   late final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, CubitState>(
      builder: (context, state) {
        if (state is LoadedState) {
          var data = state.httpData;
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  _buildGoogleMap(context),
                  Column(
                    children: [
                      zoomMinus(),
                      zoomPLus(),
                    ],
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  findQuake(data);
                },
                child: const Text('Find Quake'),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget zoomMinus() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.remove_circle),
        onPressed: () {
          _zoomValue--;
          _minus(_zoomValue);
        },
      ),
    );
  }
  Widget zoomPLus() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.add_circle),
        onPressed: () {
          _zoomValue++;
          _minus(_zoomValue);
        },
      ),
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        initialCameraPosition: const CameraPosition(target: _centrer),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markerList),
      ),
    );
  }

  void findQuake(QuakeModel data) {
    setState(() {
      _markerList.clear(); // clear the map at the beginning
      _handleResponse(data);
    });
  }

  void _handleResponse(QuakeModel data) {
    setState(
      () {
        data.features?.forEach(
          (element) {
            _markerList.add(
              Marker(
                  markerId: MarkerId(element.id!),
                  infoWindow: InfoWindow(
                    snippet: element.properties!.title,
                    title: element.properties!.mag.toString(),
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueMagenta,
                  ),
                  position: LatLng(element.geometry!.coordinates![1],
                      element.geometry!.coordinates![0])),
            );
          },
        );
      },
    );
  }

  Future<void> _minus(double zoomvalue) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: const LatLng(40.712776, -74.005974), zoom: zoomvalue),
      ),
    );
  }
}
