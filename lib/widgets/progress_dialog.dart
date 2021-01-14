import 'package:cargic_ninja/utils/colors.dart';
import 'package:flutter/material.dart';

class ProgressDialoger extends StatefulWidget {
  ProgressDialoger({this.message});
  final String message;
  @override
  _ProgressDialogerState createState() => _ProgressDialogerState();
}

class _ProgressDialogerState extends State<ProgressDialoger> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            SizedBox(width: 5),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(CargicColors.brandBlue),
            ),
            SizedBox(width: 20),
            Text(
              '${widget.message}',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
