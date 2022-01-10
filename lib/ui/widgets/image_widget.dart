import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:visual_notes/ui/resources/constants.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({Key? key, this.imagePath, this.onClicked}) : super(key: key);
  final String? imagePath;
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4.w,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    late ImageProvider image;
    if (imagePath != null) {
      image = FileImage(File(imagePath!));
    } else {
      image = AppConstants.imagePlaceHolder;
    }
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          height: 100.r,
          width: 100.r,
          image: image,
          fit: BoxFit.cover,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
        all: 6.r,
        color: color,
        child: Icon(
          Icons.edit,
          size: 16.sp,
          color: Colors.white,
        ),
      );

  Widget buildCircle({
    required double all,
    required Color color,
    required Widget child,
  }) =>
      Container(
        child: child,
        padding: EdgeInsets.all(all),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          shape: BoxShape.circle,
          color: color,
        ),
      );
}
