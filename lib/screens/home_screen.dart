import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parking_locator/models/place.dart';
import 'package:parking_locator/services/geolocator_service.dart';
import 'package:parking_locator/services/marker_service.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      ? Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              width: MediaQuery.of(context).size.width,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(currentPosition.latitude,
                                      currentPosition.longitude),
                                  zoom: 16.0,
                                ),
                                zoomControlsEnabled: true,
                                markers: Set<Marker>.of(markers),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Expanded(
                              child: ListView.builder(
                                itemCount: places.length,
                                itemBuilder: (context, index) {
                                  return FutureProvider(
                                    initialData: null,
                                    create: (context) => geoService.getDistance(
                                      currentPosition.latitude,
                                      currentPosition.longitude,
                                      places[index].geometry.location.lat,
                                      places[index].geometry.location.lng,
                                    ),
                                    child: Card(
                                      child: ListTile(
                                        title: Text(places[index].name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5.0),
                                            Row(
                                              children: [
                                                RatingBarIndicator(
                                                  rating:
                                                      places[index].rating ??
                                                          0.0,
                                                  itemBuilder:
                                                      (context, index) =>
                                                          const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 15.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5.0),
                                            Consumer<double?>(
                                              builder:
                                                  (contex, meters, widget) {
                                                return (meters != null)
                                                    ? Text(
                                                        '${places[index].vicinity} \u00b7 ${meters.round()} m.',
                                                      )
                                                    : Container();
                                              },
                                            )
                                          ],
                                        ),
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.directions,
                                            color: Colors.blue,
                                          ),
                                          onPressed: () => _launchMapsUrl(
                                            places[index].geometry.location.lat,
                                            places[index].geometry.location.lng,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
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
