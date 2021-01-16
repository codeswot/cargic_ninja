import 'dart:ui';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/candy_button.dart';
import 'package:cargic_ninja/widgets/count_down.dart';
import 'package:flutter/material.dart';

class JobAlerts extends ModalRoute<void> {
  JobAlerts({
    this.location,
    this.jobName,
  });
  final String location;
  final String jobName;
  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache cache = new AudioCache();

  String alertPath = "alert.mp3";

  playSound() async {
    audioPlayer = await cache.play(alertPath);

    // int result =
    //     await audioPlayer.play(alertPath, isLocal: true, stayAwake: true);
    if (1 == 1) {
      print('Success');
    }
  }

  stopSound() async {
    await audioPlayer.stop();
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    playSound();
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 10.5, sigmaX: 9.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'JOB REQUEST',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              children: [
                Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: CargicColors.plainWhite,
                      width: 2.1,
                    ),
                  ),
                  child: CountDownTimer(
                    secondsRemaining: 60,
                    whenTimeExpires: () {
                      Navigator.pop(context);
                      stopSound();
                    },
                    countDownTimerStyle: TextStyle(
                      color: CargicColors.plainWhite,
                      fontSize: 45,
                    ),
                  ),
                ),
                //
                SizedBox(height: 32),
                Text(
                  (jobName != null) ? jobName : '',
                  style: TextStyle(
                    color: CargicColors.plainWhite,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10),

                Text(
                  'Job Location',
                  style: TextStyle(
                    color: CargicColors.plainWhite,
                    fontSize: 15,
                  ),
                ),
                Text(
                  (location != null) ? location : '',
                  style: TextStyle(
                    color: CargicColors.plainWhite,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Flexible(
                    child: CandyButton(
                        buttonColor: CargicColors.fearYellow,
                        titleColor: CargicColors.brandBlue,
                        title: 'DECLINE',
                        onPressed: () {
                          Navigator.pop(context);
                          stopSound();
                        }),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: CandyButton(
                      title: 'ACCEPT',
                      titleColor: CargicColors.plainWhite,
                      buttonColor: CargicColors.willGreen,
                      onPressed: () {
                        print(
                          'Accepted',
                        );
                        Navigator.pop(context);
                        stopSound();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
