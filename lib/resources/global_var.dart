import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

DatabaseReference reqRef;
Position currentPosition;
StreamSubscription<Position> homeTabPositionSub;
StreamSubscription<Position> ridePositionSub;
String mapKeyAndroid = 'AIzaSyBgWXZ8KHoh6dy4opR1sJFvm3QjWyGnFO0';
String mapKeyiOS = 'AIzaSyCiSYi4Xp88Hmu72fXxSjCz3VKlMNvubz8';
