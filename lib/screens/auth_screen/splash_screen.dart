import 'package:cargic_ninja/screens/auth_screen/login_method_screen.dart';
import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/candy_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
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
