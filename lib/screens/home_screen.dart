import 'dart:async';

import 'package:cargic_ninja/helpers/fbm_helper.dart';
import 'package:cargic_ninja/helpers/location_helper.dart';
import 'package:cargic_ninja/providers/app_data.dart';
import 'package:cargic_ninja/resources/global_var.dart';
import 'package:cargic_ninja/screens/change_location_screen.dart';
import 'package:cargic_ninja/screens/jobs_screen/jobs_screen.dart';
import 'package:cargic_ninja/utils/global_variables.dart';
import 'package:cargic_ninja/widgets/brand_name.dart';
import 'package:cargic_ninja/widgets/job_card.dart';
import 'package:cargic_ninja/widgets/location_card.dart';
import 'package:cargic_ninja/widgets/ninja_card.dart';
import 'package:cargic_ninja/widgets/online_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class NinjaHome extends StatefulWidget {
  static const String id = 'NinjaHome';
  @override
  _NinjaHomeState createState() => _NinjaHomeState();
}

class _NinjaHomeState extends State<NinjaHome> {
  Geolocator _geolocator = Geolocator();
  Position currentPosition;
  LocationHelper _locationHelper = LocationHelper();

  getUserPosition() async {
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    // confirm location
    await _locationHelper.findCoordAddress(currentPosition, context);
  }

  FbmAlerts _nottification = FbmAlerts();
  void initFbm() {
    _nottification.initialize(context);
    _nottification.getToken();
  }

  bool isOnline = false;
  String title = 'Go Online';
  @override
  void initState() {
    initFbm();
    getUserPosition();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserPosition();
    if (isOnline) {
      title = 'Go Offline';
    } else {
      title = 'Go Online';
    }
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: CargicBrandName(width: 20, height: 20),
        titleSpacing: -3,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              LocationCard(
                location: Provider.of<AppData>(context).userAdress.placeName,
                onTap: () {
                  Navigator.of(context).pushNamed(ChangeLocationScreen.id);
                },
              ),
              NinjaCard(
                ninjaImage: '',
                ninjaName: 'Yusuf Damu',
                onRefreshPress: () {},
              ),
              OnlineCard(
                title: title,
                onChanged: (val) {
                  setState(() {
                    isOnline = val;
                    if (isOnline) {
                      isOnline = true;
                      goOnline();
                    } else {
                      isOnline = false;
                      goOffline();
                    }
                  });
                },
                value: isOnline,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: JobsCard(
                      count: 0,
                      title: 'Pending Jobs',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JobScreen(index: 0),
                          ),
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: JobsCard(
                      count: 1,
                      title: 'Upcoming Jobs',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JobScreen(index: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);

  void getLocationUpdate() async {
    homeTabPositionSub = _geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) async {
      currentPosition = position;
      bool response = await Geofire.setLocation(
          currentFirebaseUser.uid, position.latitude, position.longitude);
      LatLng pos = LatLng(position.latitude, position.longitude);
    });
  }

  void goOnline() async {
    Geofire.initialize('ninjasAvailable');

    bool response = await Geofire.setLocation(currentFirebaseUser.uid,
        currentPosition.latitude, currentPosition.longitude);
    reqRef = FirebaseDatabase.instance
        .reference()
        .child('ninjas/${currentFirebaseUser.uid}/newReq');
    reqRef.set('waiting');
    reqRef.onValue.listen((event) {
      // print(event);
    });
    getLocationUpdate();
  }

  void goOffline() {
    Geofire.removeLocation(currentFirebaseUser.uid);
    if (reqRef != null) {
      reqRef.onDisconnect();
      reqRef.remove();
    }

    reqRef = null;
  }
}
