import 'package:appo/src/shared/constants/app_break_points.dart';
import 'package:appo/src/shared/constants/app_constants.dart';
import 'package:appo/src/shared/constants/app_typography.dart';
import 'package:flutter/material.dart';
import '../shared.dart';

enum ScreenSize { small, medium, large }

/// The UIBuilder class calculator that converts screen size into design
/// decisions in one central place.
///
/// Creation:
/// - Its creation is from the layoutbuilder which gives it the constraits that
/// it needs dependant on the screen size. For example, for a phone like pixel 6,
/// the layout widget will get the constraits (sizes of the pixel phone) and
/// assign those to the UIBuilder
///
///
/// Use:
/// - The Ui Builder now uses those constraits to determine who the styles of
/// app and its components will be done.
/// - For example, if screen size is less than 600px (mobile view), the font size
/// maybe 20.0sp while if greater than 600px (tablet view) the font size will be
/// 32.0sp and so on...
/// - The UIBuilder has several systling methods, including, fonts, decoraction,
/// gradients, spacing, and other syling function.
class UIBuilder {
  const UIBuilder({required this.constraints});
  final BoxConstraints constraints;

  // ---------- SCREEN INFORMATION ------------

  ScreenSize get screenSize {
    if (constraints.maxWidth < AppBreakPoints.mobileWidth) {
      return ScreenSize.small;
    } else if (constraints.maxWidth > AppBreakPoints.mobileWidth &&
        constraints.maxWidth < AppBreakPoints.tabletWidth) {
      return ScreenSize.medium;
    } else {
      return ScreenSize.large;
    }
  }

  bool get isMobile => screenSize == ScreenSize.small;
  bool get isTablet => screenSize == ScreenSize.medium;
  bool get isDesktop => screenSize == ScreenSize.large;

  //  --------- Widget Spaceing --------
  double get verticalWidgetSpacing => isMobile
      ? 8
      : isTablet
      ? 16
      : 24;

  double get circleAvatarRadius {
    if (isMobile) return 18.0;
    if (isTablet) return 24.0;
    return 40.0;
  }

  double get circleAvatarMargin {
    if (isMobile) return 18.0;
    if (isTablet) return 32.0;
    return 40.0;
  }

  double get circleAvatarIconSize {
    if (isMobile) return 14.0;
    if (isTablet) return 24.0;
    return 32.0;
  }

  // ---------- FONT SIZES ----------
  double get captionSize {
    if (isMobile) return AppTypography.captionSmall;
    if (isTablet) return AppTypography.captionMedium;
    return AppTypography.captionLarge;
  }

  double get labelSize {
    if (isMobile) return AppTypography.labelSmall;
    if (isTablet) return AppTypography.labelMedium;
    return AppTypography.labelLarge;
  }

  double get headerSize {
    if (isMobile) return AppTypography.headerSmall;
    if (isTablet) return AppTypography.headerMedium;
    return AppTypography.headerLarge;
  }

  BoxDecoration buttonDecoration({required int number}) {
    return BoxDecoration(
      color: number.isNegative ? AppColors.primary : Colors.black,
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey, width: 2.0),
      boxShadow: const [
        BoxShadow(
          color: Color(0x08000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
        BoxShadow(
          color: Color(0x12000000),
          blurRadius: 24,
          offset: Offset(0, 8),
        ),
      ],
    );
  }

  BoxDecoration get displayDecoration => const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    boxShadow: [
      BoxShadow(
        color: Color(0x16363535),
        blurRadius: 60.0,
        offset: Offset(0, 30),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x16363535),
        blurRadius: 60.0,
        offset: Offset(0, -30),
        spreadRadius: 0,
      ),
    ],
  );

  BoxDecoration get calenderSelectionDecoration => BoxDecoration(
    color: Colors.black,
    border: Border.all(color: Colors.black38, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  TextStyle headerStyle({required bool isWeekend}) => TextStyle(
    fontSize: headerSize,
    fontWeight: FontWeight.bold,
    color: isWeekend ? AppColors.primary : AppColors.secondary,
  );

  TextStyle displayStyle({bool isBold = true}) {
    return TextStyle(
      color: AppColors.textGrey,
      fontSize: captionSize,
      fontWeight: isBold ? FontWeight.bold : null,
    );
  }

  double get toggleIconSize {
    if (isMobile) return 12.0;
    if (isTablet) return 20.0;
    return 24.0;
  }

  double get toggleMargin {
    if (isMobile) return 8.0;
    if (isTablet) return 10.0;
    return 12.0;
  }

  double get dayWidgetCurrentDateFont => isMobile ? 16 : 24;
  double get dayWidgetOtherDateFont => isMobile ? 12 : 16;
  // ---------- TEXT STYLES ----------
  TextStyle get labelStyle => TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: isMobile ? 14.0 : 18.0,
  );

  TextStyle get dateStyle => TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: isMobile ? 16.0 : 20.0,
  );

  // ---------- WIDGET SIZES ---------
  double get dayWidgetSize => isMobile ? 50.0 : 95.0;

  double get roundButtonSize => isMobile
      ? AppConstants.regularSmall
      : isTablet
      ? AppConstants.regularMedium
      : AppConstants.regularLarge;

  TextStyle get roundButtonTextStyle =>
      TextStyle(fontSize: labelSize, color: Colors.white);

  // ---------- TYPOGRAPHY ---------
  TextStyle get startDateString =>
      TextStyle(color: Colors.white, fontSize: captionSize);

  TextStyle get startDate => TextStyle(
    color: Colors.white,
    fontSize: labelSize,
    fontWeight: FontWeight.bold,
  );

  TextStyle get adjusterText => TextStyle(color: Colors.black, fontSize: 12.0);

  TextStyle get adjusterNumber => TextStyle(
    color: Colors.black,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
  );

  // ---------- SPACING -----------
  double get layoutSpacing => isMobile ? 60 : 120;
}
