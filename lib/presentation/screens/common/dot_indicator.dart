import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_theater/presentation/utils/colors/app_colors_util.dart';

class DotsIndicator extends AnimatedWidget {
  const DotsIndicator({super.key,
    required this.controller,
    required this.itemCount,
    required this.onPageSelected,
    required this.listViewController,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  final ScrollController listViewController;

  /// The number of items managed by the PageController
  final int? itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int>? onPageSelected;

  // The base size of the dots
  static const double _kDotSize = 6.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2;

  // The distance between the center of each dot
  static const double _kDotSpacing = 16.0;

  Widget _buildDot(int index) {
    double selectedNess = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedNess;
    return SizedBox(
      width: _kDotSpacing,
      child: Center(
        child: Material(
          color: controller.page?.ceil() == index
              || controller.page?.floor() == index
              ? AppColorsUtils.lightBackColor
              : index == 0 && controller.page==null
              ? AppColorsUtils.lightBackColor
              : AppColorsUtils.darkBackColor,
          type: MaterialType.circle,
          child: SizedBox(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: InkWell(
              onTap: () {
                onPageSelected!(index);},
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 40,
          child: ListView(
            controller: listViewController,
            scrollDirection: Axis.horizontal,
            children: List<Widget>.generate(itemCount!, _buildDot),
          ),
        ),
      ],
    );
  }
}