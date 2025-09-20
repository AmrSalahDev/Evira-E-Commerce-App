// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/apple.svg
  SvgGenImage get apple => const SvgGenImage('assets/icons/apple.svg');

  /// File path: assets/icons/facebook.svg
  SvgGenImage get facebook => const SvgGenImage('assets/icons/facebook.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// List of all assets
  List<SvgGenImage> get values => [apple, facebook, google];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/lets_you_in_dark.png
  AssetGenImage get letsYouInDark =>
      const AssetGenImage('assets/images/lets_you_in_dark.png');

  /// File path: assets/images/lets_you_in_light.png
  AssetGenImage get letsYouInLight =>
      const AssetGenImage('assets/images/lets_you_in_light.png');

  /// Directory path: assets/images/onboarding
  $AssetsImagesOnboardingGen get onboarding =>
      const $AssetsImagesOnboardingGen();

  /// Directory path: assets/images/splash
  $AssetsImagesSplashGen get splash => const $AssetsImagesSplashGen();

  /// List of all assets
  List<AssetGenImage> get values => [letsYouInDark, letsYouInLight];
}

class $AssetsImagesOnboardingGen {
  const $AssetsImagesOnboardingGen();

  /// File path: assets/images/onboarding/onboarding_dark_1.png
  AssetGenImage get onboardingDark1 =>
      const AssetGenImage('assets/images/onboarding/onboarding_dark_1.png');

  /// File path: assets/images/onboarding/onboarding_dark_2.png
  AssetGenImage get onboardingDark2 =>
      const AssetGenImage('assets/images/onboarding/onboarding_dark_2.png');

  /// File path: assets/images/onboarding/onboarding_dark_3.png
  AssetGenImage get onboardingDark3 =>
      const AssetGenImage('assets/images/onboarding/onboarding_dark_3.png');

  /// File path: assets/images/onboarding/onboarding_light_1.png
  AssetGenImage get onboardingLight1 =>
      const AssetGenImage('assets/images/onboarding/onboarding_light_1.png');

  /// File path: assets/images/onboarding/onboarding_light_2.png
  AssetGenImage get onboardingLight2 =>
      const AssetGenImage('assets/images/onboarding/onboarding_light_2.png');

  /// File path: assets/images/onboarding/onboarding_light_3.png
  AssetGenImage get onboardingLight3 =>
      const AssetGenImage('assets/images/onboarding/onboarding_light_3.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    onboardingDark1,
    onboardingDark2,
    onboardingDark3,
    onboardingLight1,
    onboardingLight2,
    onboardingLight3,
  ];
}

class $AssetsImagesSplashGen {
  const $AssetsImagesSplashGen();

  /// File path: assets/images/splash/logo.png
  AssetGenImage get logo =>
      const AssetGenImage('assets/images/splash/logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [logo];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

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
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
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

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    _svg.ColorMapper? colorMapper,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
        colorMapper: colorMapper,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
