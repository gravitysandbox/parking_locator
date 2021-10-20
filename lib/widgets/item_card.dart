import 'package:flutter/material.dart';
import 'package:parking_locator/models/place.dart';
import 'package:parking_locator/widgets/place_distance.dart';
import 'package:parking_locator/widgets/rating_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCard extends StatelessWidget {
  final Place? place;
  const ItemCard({Key? key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: ListTile(
        title: Text(place!.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5.0),
            RatingIndicator(place: place),
            const SizedBox(height: 5.0),
            PlaceDistance(place: place),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.directions,
            color: Colors.blue,
          ),
          onPressed: () => _launchMapsUrl(
            place!.geometry.location.lat,
            place!.geometry.location.lng,
          ),
        ),
      ),
    );
  }

  void _launchMapsUrl(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
