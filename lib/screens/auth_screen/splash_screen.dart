import 'package:cargic_ninja/helpers/location_helper.dart';
import 'package:cargic_ninja/screens/auth_screen/login_method_screen.dart';
import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/candy_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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

  @override
  Widget build(BuildContext context) {
    getUserPosition();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 75),
              child: Text(
                'Ninja App',
                style: TextStyle(
                  color: CargicColors.brandBlue,
                  fontWeight: FontWeight.w800,
                  fontSize: 29,
                ),
              ),
            ),
            Container(
              height: 200,
              width: 200,
              color: CargicColors.fairGrey,
            ),
            Column(
              children: [
                Text(
                  'Using this App Cargic Ninjas (Handymen) \nget service request  and get the \nlocation of the costumer  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CargicColors.grimBlack,
                    fontSize: 16,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 35),
                  child: CandyButton(
                    title: 'Get Started ',
                    buttonColor: CargicColors.brandBlue,
                    titleColor: CargicColors.plainWhite,
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginMethodScreen.id);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
