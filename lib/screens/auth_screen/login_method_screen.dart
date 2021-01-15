import 'package:cargic_ninja/helpers/auth_helper.dart';
import 'package:cargic_ninja/helpers/location_helper.dart';
import 'package:cargic_ninja/screens/auth_screen/login_with_email.dart';
import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/brand_logo.dart';
import 'package:cargic_ninja/widgets/candy_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LoginMethodScreen extends StatefulWidget {
  static const String id = 'LoginMethodScreen';

  @override
  _LoginMethodScreenState createState() => _LoginMethodScreenState();
}

class _LoginMethodScreenState extends State<LoginMethodScreen> {
  LocationHelper _locationHelper = LocationHelper();
  AuthHelper _authHelper = AuthHelper();

  Geolocator _geolocator = Geolocator();
  Position currentPosition;

  getUserPosition() async {
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    // confirm location
    await _locationHelper.findCoordAddress(currentPosition, context);
  }

  @override
  Widget build(BuildContext context) {
    // getUserPosition();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BrandLogo(),
            Container(
              margin: EdgeInsets.only(left: 49.5, right: 49.5),
              child: Text(
                'By login to our service your data will be saved and accessible from different devices',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(30.0),
              padding: EdgeInsets.only(
                left: 27.0,
                right: 27.0,
                top: 52.0,
                bottom: 52.0,
              ),
              decoration: BoxDecoration(
                color: CargicColors.plainWhite,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8.0,
                    offset: Offset(0, 4.0),
                    color: CargicColors.cosmicShadow,
                  ),
                ],
              ),
              child: Column(
                children: [
                  CandyButton(
                    buttonColor: CargicColors.plainWhite,
                    titleColor: CargicColors.smoothGray,
                    iconColor: CargicColors.rageRed,
                    buttonIcon: 'images/google_icon.svg',
                    title: 'Login with Google',
                    onPressed: () {
                      _authHelper.signInWithGoogle();
                    },
                  ),
                  SizedBox(height: 32.0),
                  CandyButton(
                    buttonColor: CargicColors.hopeBlue,
                    titleColor: CargicColors.plainWhite,
                    iconColor: CargicColors.plainWhite,
                    buttonIcon: 'images/email_icon.svg',
                    title: 'Login with Email',
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginWithEmailScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
