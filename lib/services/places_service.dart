import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:parking_locator/models/place.dart';
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyBHDqceZqA-4xS29S0QQOgRoVeii5iMefs';

  Future<List<Place>> getPlaces(
      double lat, double lng, BitmapDescriptor icon) async {
    var response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=parking&rankby=distance&key=$key'));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;

    return jsonResults.map((place) => Place.fromJson(place, icon)).toList();
  }
}
