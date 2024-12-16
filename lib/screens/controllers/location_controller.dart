import 'dart:async';

import 'package:location/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_controller.g.dart';

@Riverpod(keepAlive: true)
class UserLatitude extends _$UserLatitude {
  @override
  FutureOr<String> build() {
    return '';
  }

  updateLat(String latValue) {
    state = AsyncData(latValue);
  }
}

@Riverpod(keepAlive: true)
class UserLongitude extends _$UserLongitude {
  @override
  FutureOr<String> build() {
    return '';
  }

  updateLong(String longValue) {
    state = AsyncData(longValue);
  }
}

@riverpod
class NewLocationController extends _$NewLocationController {
  @override
  FutureOr<dynamic> build() {}

  Future<void> getCurrentLocation() async {
    try {
      final Location location = Location();

      LocationData _location;
      late StreamSubscription<LocationData> _locationSubscription;
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return null;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return null;
        }
      }

      _location = await location.getLocation();

      _locationSubscription =
          location.onLocationChanged.handleError((dynamic err) {
        _locationSubscription.cancel();
      }).listen((LocationData currentLocation) {
        _location = currentLocation;
        // return currentLocation;
      });
      ref
          .read(userLatitudeProvider.notifier)
          .updateLat(_location.latitude.toString());
      ref
          .read(userLongitudeProvider.notifier)
          .updateLong(_location.longitude.toString());
      // _subjectLocation.sink.add(_location);
      // _latitudeController.sink.add(_location.latitude.toString());
      // _longitudeController.sink.add(_location.longitude.toString());
    } catch (error) {
      // _subjectLocation.sink.addError(error);
    }
  }
}
