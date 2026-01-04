import 'package:appo/src/shared/constants/app_break_points.dart';
import 'package:appo/src/shared/theme/theme.dart';

class AppConstants {
  static const colors = AppColors;
  static Type get breakPoints => AppBreakPoints;
  // ------ BREAK POINTS --------

  // -------- BUTTON SIZES --------
  static const double regularSmall = 50.0;
  static const double regularMedium = 65.0;
  static const double regularLarge = 80.0;

  static const double toggleSmall = 40.0;
  static const double toggleMedium = 50.0;
  static const double toggleLarge = 70.0;

  //  ------ FONT SIZES --------
  static const mobileFontSize = 16.0;
  static const tabletFontSize = 24.0;
  static const desktopFontSize = 32.0;
}
