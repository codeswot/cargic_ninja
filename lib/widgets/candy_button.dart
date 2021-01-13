import 'package:cargic_ninja/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CandyButton extends StatelessWidget {
  const CandyButton({
    Key key,
    this.title,
    this.buttonIcon,
    this.buttonColor,
    this.iconColor,
    this.titleColor,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final String buttonIcon;
  final Color buttonColor;
  final Color iconColor;
  final Color titleColor;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 19.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: (buttonColor != null) ? buttonColor : CargicColors.plainWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: 8.0,
              offset: Offset(0, 4.0),
              color: CargicColors.cosmicShadow,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: SvgPicture.asset(
                (buttonIcon != null) ? buttonIcon : '',
                color:
                    (iconColor != null) ? iconColor : CargicColors.pitchBlack,
                width: 17.6,
                height: 18.0,
              ),
            ),
            Text(
              (title != null) ? title : 'Button title here',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color:
                    (titleColor != null) ? titleColor : CargicColors.pitchBlack,
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
