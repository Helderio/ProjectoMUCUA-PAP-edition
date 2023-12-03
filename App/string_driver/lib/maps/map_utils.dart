import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  MapUtils._();

  static void launchMapFromSourceToDestination(
      sourceLat, sourceLng, destinationLat, destinationLng) async {
    String mapOptions = [
      'saddr=$sourceLat,$sourceLng',
      'daddr=$destinationLat,$destinationLng',
      'dir_action=navigate'
    ].join('&');

    final mapUrl = 'https://www.google.com/maps?$mapOptions';

    // ignore: deprecated_member_use
    if (await canLaunch(mapUrl)) {
      // ignore: deprecated_member_use
      await launch(mapUrl);
    } else {
      throw "Não foi possível iniciar. $mapUrl";
    }
  }
}
