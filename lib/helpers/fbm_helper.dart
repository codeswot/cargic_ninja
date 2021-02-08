import 'dart:io';

import 'package:cargic_ninja/models/back_end/request_details.dart';
import 'package:cargic_ninja/utils/global_variables.dart';
import 'package:cargic_ninja/widgets/job_alerts.dart';
import 'package:cargic_ninja/widgets/progress_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FbmAlerts {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  Future initialize(context) async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        getUserID(message, context);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        getUserID(message, context);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        getUserID(message, context);
      },
    );
  }

  Future<String> getToken() async {
    String token = await _firebaseMessaging.getToken();
    print('fbm Token $token');
    DatabaseReference tokenRef = FirebaseDatabase.instance.reference().child(
          'ninjas/${currentFirebaseUser.uid}/token',
        );
    tokenRef.set(token);

    _firebaseMessaging.subscribeToTopic('allninjas');
    _firebaseMessaging.subscribeToTopic('allusers');
    return token;
  }

  String getUserID(Map<String, dynamic> message, context) {
    String reqID = '';
    if (Platform.isAndroid) {
      reqID = message['data']['req_id'];
      print('reqUser ID => $reqID');
      fetchReqInfo(reqID, context);
    }
    return reqID;
  }

  void fetchReqInfo(String reqID, context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialoger(
        message: 'Please wait...',
      ),
    );
    DatabaseReference rideRef =
        FirebaseDatabase().reference().child('cargicReq/$reqID');
    rideRef.once().then((DataSnapshot snapshot) {
      //
      Navigator.pop(context);
      if (snapshot != null) {
        print(snapshot.value);
        //req info
        String reqStatus = snapshot.value['status'].toString();
        String reqOrderID = snapshot.value['orderID'].toString();
        int reqPrice = int.parse(snapshot.value['price']);
        String reqServieName = snapshot.value['serviceName'].toString();
        String reqServieType = snapshot.value['serviceType'].toString();
        String reqDateTime = snapshot.value['formattedDate'].toString();
        var reqDate = snapshot.value['date'];
        var reqTime = snapshot.value['time'];
        //req car info
        // String reqVehicleType =
        //     snapshot.value['carDetails']['vehicleType'].toString();
        // String reqVehicleName =
        //     snapshot.value['carDetails']['vehicleName'].toString();
        // String reqVehicleModel =
        //     snapshot.value['carDetails']['vehicleModel'].toString();
        // String reqVehicleYear =
        //     snapshot.value['carDetails']['vehicleManufactureYear'].toString();
        // String reqVehicleFuelType =
        //     snapshot.value['carDetails']['vehicleFuelType'].toString();
        //get reqUser info
        double reqUserLat =
            double.parse(snapshot.value['user']['lat'].toString());
        double reqUserLng =
            double.parse(snapshot.value['user']['lng'].toString());
        String reqUserAdress = snapshot.value['user']['address'];
        String reqUserName = snapshot.value['user']['name'];
        String reqUserPhone = snapshot.value['user']['phone'];
        // String paymentMethod = snapshot.value['paymentMethod'];

        RequestDetails requestDetails = RequestDetails();
        //user info
        requestDetails.reqUserID = reqID;
        requestDetails.reqUserName = reqUserName;
        requestDetails.reqUserPhone = reqUserPhone;
        requestDetails.reqUserAddress = reqUserAdress;
        requestDetails.reqUserLocation = LatLng(reqUserLat, reqUserLng);
        //req info
        requestDetails.reqJobName = reqServieName;
        //req car info

        // tripDetails.destinationAddress = destiAdress;

        // tripDetails. = pickupAdress;
        // tripDetails.destinationAddress = destiAdress;
        // tripDetails.pickupLocation = LatLng(pickUpLat, pickUpLng);
        // tripDetails.destinationLocation = LatLng(destiLat, destiLng);
        // tripDetails.paymentMethod = paymentMethod;
        // tripDetails.riderName = riderName;
        // tripDetails.riderPhone = riderPhone;

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return NewJobAllert(requestDetails);
            });
        // print('${tripDetails.paymentMethod}');
      }
    });
  }
}
