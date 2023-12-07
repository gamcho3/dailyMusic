/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $ImagesGen {
  const $ImagesGen();

  /// File path: images/album.png
  AssetGenImage get album => const AssetGenImage('images/album.png');

  /// File path: images/music.png
  AssetGenImage get music => const AssetGenImage('images/music.png');

  /// File path: images/next.png
  AssetGenImage get next => const AssetGenImage('images/next.png');

  /// File path: images/pause.png
  AssetGenImage get pause => const AssetGenImage('images/pause.png');

  /// File path: images/play.png
  AssetGenImage get playPng => const AssetGenImage('images/play.png');

  /// File path: images/play.svg
  String get playSvg => 'images/play.svg';

  /// File path: images/repeat.png
  AssetGenImage get repeat => const AssetGenImage('images/repeat.png');

  /// File path: images/unnamed.png
  AssetGenImage get unnamed => const AssetGenImage('images/unnamed.png');

  /// File path: images/unsplash.jpg
  AssetGenImage get unsplash => const AssetGenImage('images/unsplash.jpg');

  /// List of all assets
  List<dynamic> get values =>
      [album, music, next, pause, playPng, playSvg, repeat, unnamed, unsplash];
}

class Assets {
  Assets._();

  static const $ImagesGen images = $ImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
