import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestDetails {
  String reqUserID;
  String reqUserName;
  String reqUserPhone;
  String reqUserAddress;
  LatLng reqUserLocation;
  String reqJobName;
  String reqJobType;

  RequestDetails({
    this.reqUserID,
    this.reqUserName,
    this.reqUserPhone,
    this.reqUserAddress,
    this.reqJobName,
    this.reqJobType,
    this.reqUserLocation,
  });
}
