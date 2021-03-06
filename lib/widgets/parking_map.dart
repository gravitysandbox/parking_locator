import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_locator/widgets/operation_button.dart';

class ParkingMap extends StatefulWidget {
  final List<Marker>? markers;
  final Position? position;

  const ParkingMap({Key? key, this.markers, this.position}) : super(key: key);

  @override
  State<ParkingMap> createState() => _ParkingMapState();
}

class _ParkingMapState extends State<ParkingMap> {
  final Completer<GoogleMapController> _controller = Completer();
  bool? isNormalMapType = true;

  void updateMapType(bool isNormalMapType) {
    this.isNormalMapType = isNormalMapType;
    setState(() {});
  }

  Future<void> myLocation(LatLng latLng) async {
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GoogleMap(
            mapType: isNormalMapType! ? MapType.normal : MapType.hybrid,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.position!.latitude,
                widget.position!.longitude,
              ),
              zoom: 16.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            markers: Set<Marker>.of(widget.markers!),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.06,
            left: .0,
            child: OperationButton(
              isGeolocation: false,
              onMapTypeChange: updateMapType,
            ),
          ),
          Positioned(
            right: .0,
            bottom: MediaQuery.of(context).size.height * 0.06,
            child: OperationButton(
              position: widget.position,
              isGeolocation: true,
              myLocation: myLocation,
            ),
          ),
        ],
      ),
    );
  }
}
