import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const ff = Color(0xFFFFFFFF);


CustomColors lightCustomColors = const CustomColors(
  sourceFf: Color(0xFFFFFFFF),
  ff: Color(0xFF006874),
  onFf: Color(0xFFFFFFFF),
  ffContainer: Color(0xFF97F0FF),
  onFfContainer: Color(0xFF001F24),
);

CustomColors darkCustomColors = const CustomColors(
  sourceFf: Color(0xFFFFFFFF),
  ff: Color(0xFF4FD8EB),
  onFf: Color(0xFF00363D),
  ffContainer: Color(0xFF004F58),
  onFfContainer: Color(0xFF97F0FF),
);



/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceFf,
    required this.ff,
    required this.onFf,
    required this.ffContainer,
    required this.onFfContainer,
  });

  final Color? sourceFf;
  final Color? ff;
  final Color? onFf;
  final Color? ffContainer;
  final Color? onFfContainer;

  @override
  CustomColors copyWith({
    Color? sourceFf,
    Color? ff,
    Color? onFf,
    Color? ffContainer,
    Color? onFfContainer,
  }) {
    return CustomColors(
      sourceFf: sourceFf ?? this.sourceFf,
      ff: ff ?? this.ff,
      onFf: onFf ?? this.onFf,
      ffContainer: ffContainer ?? this.ffContainer,
      onFfContainer: onFfContainer ?? this.onFfContainer,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceFf: Color.lerp(sourceFf, other.sourceFf, t),
      ff: Color.lerp(ff, other.ff, t),
      onFf: Color.lerp(onFf, other.onFf, t),
      ffContainer: Color.lerp(ffContainer, other.ffContainer, t),
      onFfContainer: Color.lerp(onFfContainer, other.onFfContainer, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith(
    );
  }
}