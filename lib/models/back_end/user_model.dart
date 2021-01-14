import 'package:firebase_database/firebase_database.dart';

class UserModel {
  String userId;
  String fullName;
  String phoneNumber;
  String email;
  UserModel({this.fullName, this.phoneNumber, this.email, this.userId});
  UserModel.fromSnapshot(DataSnapshot snapshot) {
    userId = snapshot.key;
    fullName = snapshot.value['fullname'];
    email = snapshot.value['email'];
    phoneNumber = snapshot.value['phone'];
  }
}
