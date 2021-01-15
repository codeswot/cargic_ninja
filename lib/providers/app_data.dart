import 'package:cargic_ninja/models/back_end/address_model.dart';
import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  //get ninjaInfo
  String ninjaID;
  String fullName;
  String ninjaEmail;
  String ninjaPhone;
  getUserInfo({
    String iD,
    String name,
    String email,
    String phone,
  }) {
    ninjaID = iD;
    fullName = name;
    ninjaEmail = email;
    ninjaPhone = phone;

    notifyListeners();
  }

  //for location
  // double locationLng;
  // double locationLat;
  Address userAdress;

  updateUserAddress(Address address) async {
    userAdress = address;
    notifyListeners();
  }
}
