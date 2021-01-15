import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CargicBrandName extends StatelessWidget {
  const CargicBrandName({
    Key key,
    this.width,
    this.height,
  }) : super(key: key);
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/brand_name.svg',
      width: (width != null) ? width : 40,
      height: (height != null) ? height : 30,
    );
  }
}
