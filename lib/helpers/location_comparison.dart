// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
//
// import '../firebase_auth_hierarchy/auth_controller.dart';
//
// Future<bool> isWithinDistance({required String gpsLocation}) async {
//   final authController = Get.find<AuthController>();
//   Position userLocation = await Geolocator.getCurrentPosition();
//   List<String> coordinates = gpsLocation.split('-');
//   double distanceInMeters = await Geolocator.distanceBetween(
//     double.parse(coordinates[0]),
//     double.parse(coordinates[1]),
//     userLocation.latitude,
//     userLocation.longitude,
//   );
//   //get the distance from api
//   return distanceInMeters <=
//       int.parse(authController.sysInfoModel!.custLocAcu ?? '500');
// }
