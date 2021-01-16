import 'package:cargic_ninja/utils/colors.dart';
import 'package:flutter/material.dart';

class JobsCard extends StatelessWidget {
  const JobsCard({
    Key key,
    this.title,
    this.count,
    this.onTap,
  }) : super(key: key);
  final String title;
  final int count;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CargicColors.brandBlue,
              ),
              child: Center(
                child: Text(
                  (count != null) ? '${count.toString()}' : '0',
                  style: TextStyle(
                    color: CargicColors.fearYellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              (title != null) ? title : '',
              style: TextStyle(
                color: CargicColors.smoothGray,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
