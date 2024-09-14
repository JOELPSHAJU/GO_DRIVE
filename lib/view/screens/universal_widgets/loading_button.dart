import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

MaterialButton loadingButton(
    {required Size media,
    required VoidCallback onPressed,
    required Color color}) {
  return MaterialButton(
    onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    minWidth: media.width,
    height: 55,
    color: color,
    child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
      color: white,
      size: 40,
    )),
  );
}
