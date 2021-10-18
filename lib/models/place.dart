import 'package:parking_locator/models/geometry.dart';

class Place {
  final String name;
  final double? rating;
  final int? userRatingCount;
  final String vicinity;
  final Geometry geometry;

  Place({
    required this.name,
    required this.rating,
    required this.userRatingCount,
    required this.vicinity,
    required this.geometry,
  });

  Place.fromJson(Map<dynamic, dynamic> parsedJson)
      : name = parsedJson['name'],
        rating =
            (parsedJson['rating'] != null) ? (parsedJson['rating'] + .0) : 0.0,
        userRatingCount = (parsedJson['user_ratings_total'] != null)
            ? parsedJson['user_ratings_total']
            : 0,
        vicinity = parsedJson['vicinity'],
        geometry = Geometry.fromJson(parsedJson['geometry']);
}
