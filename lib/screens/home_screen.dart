import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_locator/models/place.dart';
import 'package:parking_locator/services/geolocator_service.dart';
import 'package:parking_locator/services/marker_service.dart';
import 'package:parking_locator/widgets/loading_indicator.dart';
import 'package:parking_locator/widgets/parking_list.dart';
import 'package:parking_locator/widgets/parking_map.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placesProvider = Provider.of<Future<List<Place>>?>(context);
    var currentPosition = Provider.of<Position?>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider<List<Place>?>(
      initialData: null,
      create: (context) => placesProvider,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>?>(
                builder: (_, places, __) {
                  var markers = (places != null)
                      ? markerService.getMarkers(places)
                      : <Marker>[];
                  return (places != null)
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            ParkingMap(
                              position: currentPosition,
                              markers: markers,
                            ),
                            ParkingList(
                              places: places,
                              position: currentPosition,
                              geoService: geoService,
                            ),
                          ],
                        )
                      : const LoadingIndicator();
                },
              )
            : const LoadingIndicator(),
      ),
    );
  }
}
