import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPS"),
      ),
      body: Container(),
    );
  }

  Location location = Location();

  PermissionStatus? permissionStatus;

  bool isServiceEnable = false;

  void getCurrentLocation() async {
    bool isGranted = await isPermissionGranted();
    if (!isGranted) return;
    bool isService = await isServiceEnabled();
    if (!isService) return;

    LocationData locationData = await location.getLocation();

    print(locationData.latitude);
    print(locationData.longitude);
  }

  Future<bool> isServiceEnabled() async {
    isServiceEnable = await location.serviceEnabled();
    if (!isServiceEnable) {
      isServiceEnable = await location.requestService();
      return isServiceEnable;
    }
    return isServiceEnable;
  }

  Future<bool> isPermissionGranted() async {
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }
    return permissionStatus == PermissionStatus.granted;
  }
}
