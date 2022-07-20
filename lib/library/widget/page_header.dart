import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NetworkingPageHeader extends SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    required this.title,
    required this.minExtent,
    required this.image,
    required this.maxExtent,
  });
  @override
  final double minExtent;
  @override
  final double maxExtent;
  final String image;
  final String title;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 32.0,
              color: Colors.white.withOpacity(titleOpacity(shrinkOffset)),
            ),
          ),
        ),
      ],
    );
  }

  double titleOpacity(double shrinkOffset) {
    // simple formula: fade out text as soon as shrinkOffset > 0
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
    // more complex formula: starts fading out text when shrinkOffset > minExtent
    //return 1.0 - max(0.0, (shrinkOffset - minExtent)) / (maxExtent - minExtent);
  }

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
