import 'package:flutter/material.dart';
import 'dart:ui';

class BlurContainer extends StatelessWidget {
  BlurContainer({super.key, required this.child});

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(_opacity),
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            //height: MediaQuery.of(child).size.height * 1.01,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
              child: child,
            )),
      ),
    );
  }
}
