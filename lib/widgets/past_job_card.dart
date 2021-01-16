import 'package:cargic_ninja/utils/colors.dart';
import 'package:cargic_ninja/widgets/smooth_start_rating.dart';
import 'package:flutter/material.dart';

class PastJobsCard extends StatelessWidget {
  const PastJobsCard({
    Key key,
    this.orderID,
    this.dateTime,
    this.location,
    this.serviceType,
    this.rating,
  }) : super(key: key);
  final String orderID;
  final String dateTime;
  final String location;
  final String serviceType;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CargicColors.plainWhite,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: CargicColors.cosmicShadow,
            blurRadius: 5,
            offset: Offset(1.0, 2.5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (orderID != null) ? orderID : '',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                ),
              ),
              Text(
                (dateTime != null) ? dateTime : '',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Text(
            (serviceType != null) ? serviceType : '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ), //add desc
          SizedBox(height: 15),
          Row(
            children: [
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: CargicColors.willGreen,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Job Location',
                style: TextStyle(
                  fontSize: 15,
                ),
              )
            ],
          ),
          Text(
            (location != null) ? location : '',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          SizedBox(height: 20),
          SmoothStarRating(
            starCount: 5,
            rating: (rating != null) ? rating : 0.1,
            color: CargicColors.fearYellow,
            borderColor: CargicColors.fearYellow,
            size: 30,
          ),
        ],
      ),
    );
  }
}
