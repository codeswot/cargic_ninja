import 'package:cargic_ninja/utils/colors.dart';
import 'package:flutter/material.dart';

class CargicProfilePic extends StatelessWidget {
  const CargicProfilePic({
    Key key,
    @required this.image,
    this.width,
    this.height,
  }) : super(key: key);

  final String image;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width != null) ? width : 80,
      height: (height != null) ? height : 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: CargicColors.plainWhite, width: 3.5),
        boxShadow: [
          BoxShadow(
            color: CargicColors.cosmicShadow,
            blurRadius: 3,
            offset: Offset(0.0, 1.5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          (image != null) ? image : '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
