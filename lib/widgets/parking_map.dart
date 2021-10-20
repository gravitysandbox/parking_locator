import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingMap extends StatelessWidget {
  final List<Marker>? markers;
  final Position? position;

  const ParkingMap({Key? key, this.markers, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: .0,
      left: .0,
      right: .0,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              position!.latitude,
              position!.longitude,
            ),
            zoom: 16.0,
          ),
          zoomControlsEnabled: false,
          zoomGesturesEnabled: true,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          markers: Set<Marker>.of(markers!),
        ),
      ),
    );
  }
}
