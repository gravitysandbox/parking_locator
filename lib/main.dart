import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_locator/screens/home_screen.dart';
import 'package:parking_locator/services/geolocator_service.dart';
import 'package:parking_locator/services/places_service.dart';
import 'package:provider/provider.dart';

import 'models/place.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locatorService = GeoLocatorService();
    final placesService = PlacesService();

    return MultiProvider(
      providers: [
        FutureProvider(
          initialData: null,
          create: (context) => locatorService.getLocation(),
        ),
        FutureProvider(
          initialData: null,
          create: (context) {
            ImageConfiguration configuration =
                createLocalImageConfiguration(context);
            return BitmapDescriptor.fromAssetImage(
                configuration, 'assets/images/parking.png');
          },
        ),
        ProxyProvider2<Position?, BitmapDescriptor?, Future<List<Place>>?>(
          update: (context, position, icon, places) {
            return (position != null)
                ? placesService.getPlaces(
                    position.latitude, position.longitude, icon!)
                : null;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parking Locator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
