import 'package:cargic_ninja/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    Key key,
    this.onTap,
    this.location,
  }) : super(key: key);
  final Function onTap;
  final String location;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: CargicColors.brandBlue,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  child: SvgPicture.asset(
                    'images/pin_location_icon.svg',
                    color: CargicColors.plainWhite,
                    width: 15.5,
                    height: 30.5,
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Work Location',
                      style: TextStyle(color: CargicColors.plainWhite),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        (location != null) ? location : '- -',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: CargicColors.plainWhite),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: CargicColors.plainWhite,
            )
          ],
        ),
      ),
    );
  }
}
