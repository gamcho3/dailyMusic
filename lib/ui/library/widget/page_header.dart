import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NetworkingPageHeader extends SliverPersistentHeaderDelegate {
  NetworkingPageHeader({
    required this.edit,
    required this.title,
    required this.minExtent,
    required this.image,
    required this.maxExtent,
    required this.onChanged,
    required this.controller,
  });
  @override
  final double minExtent;
  @override
  final double maxExtent;
  final String image;
  final String title;
  final bool edit;
  final Function(String) onChanged;
  final TextEditingController controller;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.file(
          File(image),
          fit: BoxFit.cover,
        ),
        Positioned(
            left: 0,
            top: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.black.withOpacity(0.2),
            )),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: edit
              ? TextField(
                  controller: controller,
                  decoration: InputDecoration(border: InputBorder.none),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .primaryColor
                        .withOpacity(titleOpacity(shrinkOffset)),
                  ),
                  onChanged: onChanged,
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
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
