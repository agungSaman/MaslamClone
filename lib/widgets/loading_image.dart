import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  final double? progress;

  const LoadingImage({Key? key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(228, 228, 228, 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: CircularProgressIndicator(
          color: const Color.fromRGBO(178, 178, 178, 0.27),
          valueColor: const AlwaysStoppedAnimation<Color>(
              Color.fromRGBO(178, 178, 178, 1.0)),
          value: progress,
        ),
      ),
    );
  }
}
