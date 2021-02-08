import 'dart:ui';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cargic_ninja/helpers/helper_method.dart';
import 'package:cargic_ninja/models/back_end/request_details.dart';
import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/utils/global_variables.dart';
import 'package:cargic_ninja/widgets/candy_button.dart';
import 'package:cargic_ninja/widgets/count_down.dart';
import 'package:cargic_ninja/widgets/progress_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

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

class NewJobAllert extends StatefulWidget {
  final RequestDetails requestDetails;
  NewJobAllert(this.requestDetails);
  @override
  _NewJobAllertState createState() => _NewJobAllertState();
}

class _NewJobAllertState extends State<NewJobAllert> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache cache = new AudioCache();

  String alertPath = "alert.mp3";

  playSound() async {
    audioPlayer = await cache.loop(alertPath);
  }

  stopSound() async {
    await audioPlayer.stop();
  }

  @override
  void initState() {
    playSound();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
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
                      secondsRemaining: 61,
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
                    (widget.requestDetails.reqJobName != null)
                        ? widget.requestDetails.reqJobName
                        : '',
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
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      (widget.requestDetails.reqUserAddress != null)
                          ? widget.requestDetails.reqUserAddress
                          : '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CargicColors.plainWhite,
                        fontSize: 15,
                      ),
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
                          print('Accepted');
                          checkAvailability();
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
      ),
    );
  }

  void checkAvailability() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return ProgressDialoger(
            message: 'Please wait...',
          );
        });
    DatabaseReference newReqRef = FirebaseDatabase()
        .reference()
        .child('ninjas/${currentFirebaseUser.uid}/newReq');
    newReqRef.once().then((DataSnapshot snapshot) {
      DatabaseReference reqStatusRef = FirebaseDatabase()
          .reference()
          .child('ninjas/${currentFirebaseUser.uid}/status');
      Navigator.pop(context);
      Navigator.pop(context);
      String thisReqID = '';
      if (snapshot != null) {
        thisReqID = snapshot.value.toString();
      } else {
        Toast.show("Not Valid", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
      if (thisReqID == widget.requestDetails.reqUserID) {
        reqStatusRef.set('accepted');
        newReqRef.set('accepted');
        HelperMethods.disableHomeTabLocationUpdate();
      } else if (thisReqID == 'cancelled') {
        Toast.show("Ride cancelled", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else if (thisReqID == 'timeout') {
        Toast.show("Ride has timed out", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        Toast.show("Ride not found", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }
}
