import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60.3, bottom: 49.5),
      child: SvgPicture.asset(
        'images/brand_logo.svg',
        width: (width != null) ? width : 95.9,
        height: (height != null) ? height : 99.2,
      ),
    );
  }
}
