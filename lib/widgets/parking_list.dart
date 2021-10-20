import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parking_locator/models/place.dart';
import 'package:parking_locator/services/geolocator_service.dart';
import 'package:parking_locator/widgets/item_card.dart';
import 'package:provider/provider.dart';

class ParkingList extends StatelessWidget {
  final List<Place>? places;
  final Position? position;
  final GeoLocatorService? geoService;

  const ParkingList({Key? key, this.places, this.position, this.geoService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: .0,
      right: .0,
      bottom: .0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: const Text(
                'Parking nearby',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: places!.length,
                itemBuilder: (context, index) {
                  return FutureProvider(
                    initialData: null,
                    create: (context) => geoService!.getDistance(
                      position!.latitude,
                      position!.longitude,
                      places![index].geometry.location.lat,
                      places![index].geometry.location.lng,
                    ),
                    child: ItemCard(place: places![index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
