import 'package:geolocator/geolocator.dart';

sealed class FindLocationResult {}

final class PositionFound extends FindLocationResult {

  final double latitude;
  final double longitude;

  PositionFound({
    required this.latitude,
    required this.longitude
  });

}

final class PermissionError extends FindLocationResult {

  final bool isForever;

  PermissionError({ required this.isForever });

}

final class ServiceError extends FindLocationResult {}

final class PositionError extends FindLocationResult {}

class UserPosition {

  static Future<FindLocationResult> determinePosition() async {

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return ServiceError();
      //return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return PermissionError(isForever: false);
        //return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return PermissionError(isForever: true);
      //return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();
    return PositionFound(
      latitude: position.latitude,
      longitude: position.longitude
    );
  }

}