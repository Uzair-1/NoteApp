// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names, avoid_print, camel_case_types, await_only_futures, unnecessary_nullable_for_final_variable_declarations

import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as goa;

class LocationFind {
  late Location _location;
  bool _serviceEnable = false;
  PermissionStatus? _grantedPermission;

  LocationFind() {   // constructor
    _location = Location();
  }

  // Make a function for Check Services...
  Future<bool> _checkService() async {
    try {
      _serviceEnable = await _location.serviceEnabled();
      if (!_serviceEnable) {
        _serviceEnable = await _location.requestService();
      }
    } on PlatformException catch (error) {
      print('Error message: ${error.code}, Error code: ${error.message}');
      _serviceEnable = false;
    }
    return _serviceEnable;
  }
  // Make a function for Check Permissions...
  Future<bool> _checkPermission() async {
    if (await _checkService()) {
      _grantedPermission = await _location.hasPermission();
      if (_grantedPermission == PermissionStatus.denied) {
        _grantedPermission = await _location.requestPermission();
      }
    }
    return _grantedPermission == PermissionStatus.granted;
  }

  // Make function to access the location
  Future<LocationData?> accessLocation() async {
    if (await _checkPermission()) {
      final locationData = _location.getLocation();
      return locationData;
    }
    return null;
  }
  // Make the function to get the Place area information...
  Future<goa.Placemark?> getPlaceinfo ({required LocationData locationData}) async{
    final List<goa.Placemark>? placeInformation = await goa.placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
    );
    if(placeInformation!=null && placeInformation.isNotEmpty){
      return placeInformation[0];
    }
    return null;
  }


  // Future<goa.Placemark?> getPlaceMark({required LocationData locationData}) async {
  //   final List<goa.Placemark>? placeMarks = await goa.placemarkFromCoordinates(
  //     locationData.latitude!,
  //     locationData.longitude!,
  //   );
  //   if (placeMarks != null && placeMarks.isNotEmpty) {
  //     return placeMarks[0];
  //   }
  //   return null;
  // }
}
