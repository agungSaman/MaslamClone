// ignore_for_file: unused_import

import 'package:collection/collection.dart';
import 'package:location/location.dart';
import 'package:maps_toolkit/maps_toolkit.dart';

class LocationUtil {
  static Future<LocationData?> getCurrentCoordinate() async {
    var location = Location();
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }
}
