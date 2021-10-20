import 'package:flutter/material.dart';
import 'package:parking_locator/models/place.dart';
import 'package:provider/provider.dart';

class PlaceDistance extends StatelessWidget {
  final Place? place;
  const PlaceDistance({Key? key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<double?>(
      builder: (contex, meters, widget) {
        return (meters != null)
            ? Text(
                '${place!.vicinity} \u00b7 ${meters.round()} m.',
              )
            : Container();
      },
    );
  }
}
