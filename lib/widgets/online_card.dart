import 'package:cargic_ninja/utils/colors.dart';
import 'package:flutter/material.dart';

class OnlineCard extends StatelessWidget {
  const OnlineCard({
    Key key,
    this.onChanged,
    this.title,
    this.value,
  }) : super(key: key);
  final Function onChanged;
  final String title;
  final bool value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: CargicColors.plainWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: CargicColors.cosmicShadow,
            blurRadius: 4,
            offset: Offset(0.0, 1.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (title != null) ? title : '',
            style: TextStyle(
              color: CargicColors.smoothGray,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 90,
            height: 90,
            child: Switch(
              value: (value != null) ? value : false,
              onChanged: onChanged,
              activeColor: CargicColors.willGreen,
            ),
          ),
        ],
      ),
    );
  }
}
