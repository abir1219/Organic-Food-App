import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppWidgets {
  static Widget customButton(
      {bool isLoading = false,
      required Size size,
      required String btnName,
      required Color color,
      required void Function() func}) {
    return GestureDetector(
      onTap: () => func(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        height: size.height * .05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Center(
          child: isLoading
              ? LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.white, size: size.width * 0.08)
              : Text(
                  btnName,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
        ),
      ),
    );
  }
}
