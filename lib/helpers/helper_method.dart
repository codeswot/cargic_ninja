import 'dart:math';

import 'package:cargic_ninja/models/back_end/direction_details.dart';
import 'package:cargic_ninja/resources/global_var.dart';
import 'package:cargic_ninja/utils/global_variables.dart';
import 'package:cargic_ninja/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'http_helper.dart';

//class that handles api (url) to pass to the http helper
class HelperMethods {
  //find coords from (Position) passed param

  //url from app has (link,lng and lat from findCoord position,api key)

  Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=$mapKeyAndroid';
    var response = await RequestHelper.getRequest(url);
    if (response == 'failed') {
      return null;
    }
    DirectionDetails directionDetails = DirectionDetails();
    //
    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.encodedPoints =
        response['routes'][0]['overview_polyline']['points'];
    return directionDetails;
  }

  static int estimateFare(DirectionDetails details, int durationValue) {
    //per km (14.15)
    //per minute (N10.10)
    //base fare(5.50)
    double baseFare = 5.50;
    double distanceFare = (details.distanceValue / 1000) * 14.15;
    double timeFare = (durationValue / 60) * 10.10;
    double totalFare = baseFare + distanceFare + timeFare;
    return totalFare.truncate();
  }

  static double generateRandomNum(int max) {
    var randomGen = Random();
    int randInt = randomGen.nextInt(max);
    return randInt.toDouble();
  }

  static disableHomeTabLocationUpdate() async {
    homeTabPositionSub.pause();
    Geofire.removeLocation(currentFirebaseUser.uid);
  }

  static enableHomeTabLocationUpdate() {
    homeTabPositionSub.resume();
    Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
        currentPosition.longitude);
  }

  static void showProgress(context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return ProgressDialoger(
          message: 'Please Wait...',
        );
      },
    );
  }
}
