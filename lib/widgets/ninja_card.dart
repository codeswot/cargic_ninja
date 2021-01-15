import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/profile_pic.dart';
import 'package:flutter/material.dart';

class NinjaCard extends StatelessWidget {
  const NinjaCard({
    Key key,
    this.ninjaName,
    this.ninjaImage,
    this.onRefreshPress,
  }) : super(key: key);
  final String ninjaName;
  final String ninjaImage;
  final Function onRefreshPress;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 250,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: CargicColors.smoothGray,
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onRefreshPress,
                    child: Icon(
                      Icons.refresh,
                      color: CargicColors.plainWhite,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CargicProfilePic(
                    image: (ninjaImage != null) ? ninjaImage : '',
                    width: 179.5,
                    height: 179.5,
                  ),
                  SizedBox(height: 10),
                  Text(
                    (ninjaName != null) ? ninjaName : '',
                    style: TextStyle(
                      fontSize: 19,
                      color: CargicColors.smoothGray,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
