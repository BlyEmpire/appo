import 'package:appo/src/core/constants/colors.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DayWidget extends StatelessWidget {
  final DateTime date;

  // Font size constants
  static const double _mobileDayFontSize = 14.0;
  static const double _tabletDayFontSize = 16.0; // Reduced from 18.0
  static const double _desktopDayFontSize = 15.0;

  static const double _mobileWeekdayFontSize = 10.0;
  static const double _tabletWeekdayFontSize = 11.0; // Reduced from 12.0
  static const double _desktopWeekdayFontSize = 10.0;

  // Container size constants
  static const double _mobileContainerSize = 40.0;
  static const double _tabletContainerSize = 50.0; // Increased for tablet
  static const double _desktopContainerSize = 45.0;

  const DayWidget({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);
    final viewModel = context.watch<AppointmentScreenVm>();

    final bool isSelectedDate = date == viewModel.calculatedDate;
    final double containerSize = _getResponsiveContainerSize(context);
    final TextStyle textStyle = _getTextStyle(context, isSelectedDate);

    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("${date.day}", style: textStyle),
          Text(date.weekDayString(), style: textStyle),
        ],
      ),
    );
  }

  TextStyle _getTextStyle(BuildContext context, bool isSelectedDate) {
    final double dayFontSize = _getResponsiveDayFontSize(context);
    final double weekdayFontSize = _getResponsiveWeekdayFontSize(context);

    return TextStyle(
      fontWeight: isSelectedDate ? FontWeight.bold : FontWeight.normal,
      fontSize: isSelectedDate ? dayFontSize : weekdayFontSize,
      color: isSelectedDate ? Colors.black : AppColors.gray,
    );
  }

  double _getResponsiveDayFontSize(BuildContext context) {
    if (Responsive.isTablet(context)) {
      return _tabletDayFontSize;
    } else if (Responsive.isDesktop(context)) {
      return _desktopDayFontSize;
    } else {
      return _mobileDayFontSize;
    }
  }

  double _getResponsiveWeekdayFontSize(BuildContext context) {
    if (Responsive.isTablet(context)) {
      return _tabletWeekdayFontSize;
    } else if (Responsive.isDesktop(context)) {
      return _desktopWeekdayFontSize;
    } else {
      return _mobileWeekdayFontSize;
    }
  }

  double _getResponsiveContainerSize(BuildContext context) {
    if (Responsive.isTablet(context)) {
      return _tabletContainerSize;
    } else if (Responsive.isDesktop(context)) {
      return _desktopContainerSize;
    } else {
      return _mobileContainerSize;
    }
  }
}
