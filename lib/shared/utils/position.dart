import 'package:location/location.dart';

class Position {
  factory Position () => _instance;

  static final Position _instance = Position._();
  
  Position._() {
    _location = Location();
  }

  double get latitude   => _latitude;
  double get longitude  => _longitude;

  Future<void> start() async {
    var serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    var permissionStatus = await _location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }

    var geoData = await _location.getLocation();

    _latitude   = geoData.latitude;
    _longitude  = geoData.longitude;

  }

  Location _location;
  double _latitude = 0;
  double _longitude = 0;

}