import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../commons/base_color.dart';

class ShimmerPlaceholder extends StatelessWidget {
  final bool isLoading;
  final Widget placeholder;
  final Widget child;

  const ShimmerPlaceholder(
      {Key? key,
      required this.isLoading,
      required this.placeholder,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Visibility(visible: !isLoading, child: child),
      Visibility(
        visible: isLoading,
        child: Shimmer.fromColors(
          enabled: isLoading,
          baseColor: baseShimmerColor,
          highlightColor: shimmerColor,
          child: placeholder,
        ),
      ),
    ]);
  }
}
