import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:covid19_app/utils/constants.dart';
import 'package:covid19_app/home.dart';

class MapPage extends StatelessWidget{

  static const String routeName = '/map';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
            title: Text("Mapa"),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        drawer: AppDrawer(),
        body: MapScreen());
  }
}

class MapScreen extends StatefulWidget{
  @override
  State<MapScreen> createState()=> MapScreenState();
}

class MapScreenState extends State<MapScreen> {

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition Locationdefect = CameraPosition(
    target: LatLng(Constants.LAT_DEFECT, Constants.LON_DEFECT),
    zoom: Constants.INITIAL_ZOOM,
  );

  LocationData _currentLocation;
  var location;
  StreamSubscription<LocationData> _locationSubscription;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  @override
  void initState() {
    super.initState();
    location = new Location();
    _locationSubscription = location.onLocationChanged().listen((
        LocationData currentLocation) async {
        _currentLocation = currentLocation;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _googleMap(context)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  Widget _googleMap(BuildContext context) {
    return Stack(
      children: <Widget>[
       GoogleMap(
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        initialCameraPosition: Locationdefect,
        myLocationEnabled: true,
        markers: markers.values.toSet(),
      ),
      ]
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);

    try {
      _currentLocation = await location.getLocation();
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: 0,
          target: LatLng(_currentLocation.latitude, _currentLocation.longitude),
          zoom: Constants.INITIAL_ZOOM,
        ),
      ));
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        controller.animateCamera(CameraUpdate.newCameraPosition(
            Locationdefect,
          ));
      }
    }
  }
}
