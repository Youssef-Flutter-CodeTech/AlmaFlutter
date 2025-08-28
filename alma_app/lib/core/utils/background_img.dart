import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget backgroundImg(
        {required String img,
        bool isSvg = true,
        required Widget items,
        AlignmentGeometry alignment = AlignmentDirectional.topStart,
        Clip clip = Clip.none}) =>
    Stack(
      fit: StackFit.expand,
      alignment: alignment,
      clipBehavior: clip,
      children: [
        !isSvg
            ? Image.asset(
                img,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                colorBlendMode: BlendMode.saturation,
              )
            : SvgPicture.asset(
                img,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
        items
      ],
    );
