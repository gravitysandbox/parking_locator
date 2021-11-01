import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef MapTypeCallback = void Function(bool isNormaMapType);

class OperationButton extends StatefulWidget {
  final Position? position;
  final bool isGeolocation;
  final MapTypeCallback? onMapTypeChange;

  const OperationButton({
    Key? key,
    this.position,
    required this.isGeolocation,
    this.onMapTypeChange,
  }) : super(key: key);

  @override
  State<OperationButton> createState() => _OperationButtonState();
}

class _OperationButtonState extends State<OperationButton> {
  final Completer<GoogleMapController> _controller = Completer();
  bool isNormalMapType = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      width: 60.0,
      padding: const EdgeInsets.all(10.0),
      child: FloatingActionButton(
        elevation: 1.0,
        backgroundColor: Colors.white,
        onPressed: () {
          widget.isGeolocation ? setInitialLocation() : setMapType();
          widget.onMapTypeChange!(isNormalMapType);
        },
        child: widget.isGeolocation
            ? const Icon(
                Icons.my_location,
                color: Colors.grey,
              )
            : const Icon(
                Icons.map,
                color: Colors.grey,
              ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: Color(0xFFECEDF1),
          ),
        ),
      ),
    );
  }

  void setInitialLocation() async {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(widget.position!.latitude, widget.position!.longitude),
      zoom: 16.0,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  void setMapType() {
    isNormalMapType = !isNormalMapType;
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }

  Future<void> _disposeController() async {
    final GoogleMapController controller = await _controller.future;
    controller.dispose();
  }
}
