import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/candy_button.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String id = 'SplashScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Ninja App'),
          Container(
            height: 200,
            width: 200,
            color: CargicColors.fairGrey,
          ),
          Column(
            children: [
              Text(
                'Using this App Cargic Ninjas (Handymen) \nget service request  and get the \nlocation of the costumer  ',
              ),
              CandyButton(
                title: 'Get Started ',
                buttonColor: CargicColors.brandBlue,
                titleColor: CargicColors.plainWhite,
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
