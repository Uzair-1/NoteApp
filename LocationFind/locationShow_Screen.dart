// ignore_for_file: file_names
// // ignore_for_file: file_names, must_call_super, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_const_constructors
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'location_class.dart';
//
// class LocationShowScreen extends StatefulWidget {
//   const LocationShowScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LocationShowScreen> createState() => _LocationShowScreenState();
// }
//
// class _LocationShowScreenState extends State<LocationShowScreen> {
//   String? latitude, longitude, time, country;
//
//   @override
//   void initState() {
//     super.initState();
//     getLocationData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Loading Data'),
//             SizedBox(height: 10),
//             Text('latitude: ${latitude ?? 'Loading...'}'),
//             Text('time: ${time ?? 'Loading...'}'),
//             Text('longitude: ${longitude  ?? CircularProgressIndicator(color: Colors.blueGrey,)}'),
//             Text('country: ${country ?? CircularProgressIndicator(color: Colors.blueGrey,) }'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // for access the live the location of user...
//   void getLocationData() async {
//     final service = LocationFind();
//     final locationData = await service.accessLocation();
//     if (locationData != null) {
//       final placeinformation = await service.getPlaceinfo(locationData: locationData);
//
//       //final placemark = await service.getPlaceMark(locationData: locationData);
//       setState(() {
//         latitude = locationData.latitude?.toStringAsFixed(2) ?? 'not found';
//         time = locationData.time?.toStringAsFixed(2) ?? 'not found';
//         longitude = locationData.longitude?.toStringAsFixed(2) ?? 'not found';
//          country = placeinformation?.country ?? 'not found';
//       });
//     }
//   }
// }
