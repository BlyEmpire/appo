import 'package:appo/src/core/constants/colors.dart';
import 'package:appo/src/core/enums/time_unit.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorPanel extends StatelessWidget {
  const SelectorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // view model
    final vm = context.watch<AppointmentScreenVm>();

    return Container(
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomRadioButton(
            dateOp: DateOperation.subtract,
            onPressed: () => vm.setOperation(DateOperation.subtract),
            icon: Icons.arrow_back_ios_new_rounded,
          ),
          TodayDisplay(),
          CustomRadioButton(
            dateOp: DateOperation.add,
            onPressed: () => vm.setOperation(DateOperation.add),
            icon: Icons.arrow_forward_ios_rounded,
          ),
        ],
      ),
    );
  }
}

class TodayDisplay extends StatelessWidget {
  const TodayDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AppointmentScreenVm>();

    Responsive.init(context: context);
    return InkWell(
      onTap: () {
        // _showCalendarModal(context, selectedDate, (newDate) {
        //   selectedDate = newDate;
        // });
        _showCalendarDialog(context, vm.startDate, (newDate) {
          vm.updateDate(newDate: newDate);
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Start Date",
              style: TextStyle(color: Colors.white, fontSize: Responsive.sp(3)),
            ),
            Text(
              vm.todaysDate.formattedStringDate(),
              style: TextStyle(color: Colors.white, fontSize: Responsive.sp(4)),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomRadioButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final DateOperation dateOp;
//   final IconData icon;

//   const CustomRadioButton({
//     super.key,
//     required this.onPressed,
//     required this.dateOp,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     Responsive.init(context: context);
//     final vm = context.watch<AppointmentScreenVm>();

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GestureDetector(
//         onTap: onPressed,
//         child: Container(
//           width: 30.0,
//           height: 30.0,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: AppColors.gray,
//           ),
//           child: Container(
//             margin: EdgeInsets.all(6),
//             decoration: BoxDecoration(
//               color: dateOp == vm.operation ? Colors.white : AppColors.gray,
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                   color: dateOp == vm.operation ? Colors.white : AppColors.gray,
//                   blurRadius: 3.0,
//                   spreadRadius: 1.0,
//                   offset: Offset(0, 1),
//                 ),
//               ],
//             ),
//             child: dateOp == vm.operation
//                 ? Center(child: Icon(icon, size: 10.0))
//                 : null,
//           ),
//         ),
//       ),
//     );
//   }
// }

// void _showCalendarModal(
//   BuildContext context,
//   DateTime selectedDate,
//   Function(DateTime) onDateSelected,
// ) {
//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
//     ),
//     builder: (context) {
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TableCalendar(
//               firstDay: DateTime.utc(2020, 1, 1),
//               lastDay: DateTime.utc(2030, 12, 31),
//               focusedDay: selectedDate,
//               selectedDayPredicate: (day) {
//                 return isSameDay(day, selectedDate);
//               },
//               onDaySelected: (day, focusedDay) {
//                 onDateSelected(day);
//                 Navigator.pop(context); // Close modal after selection
//               },
//               calendarStyle: const CalendarStyle(
//                 todayDecoration: BoxDecoration(
//                   color: Colors.black,
//                   shape: BoxShape.circle,
//                 ),
//                 selectedDecoration: BoxDecoration(
//                   color: Colors.black,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

class CustomRadioButton extends StatelessWidget {
  final VoidCallback onPressed;
  final DateOperation dateOp;
  final IconData icon;

  // Size constants
  static const double _mobileContainerSize = 30.0;
  static const double _tabletContainerSize = 40.0;
  static const double _desktopContainerSize = 35.0;

  static const double _mobileIconSize = 10.0;
  static const double _tabletIconSize = 14.0;
  static const double _desktopIconSize = 12.0;

  static const double _marginSize = 8.0;
  static const double _innerMargin = 6.0;

  // Shadow constants
  static const double _shadowBlurRadius = 3.0;
  static const double _shadowSpreadRadius = 1.0;
  static const Offset _shadowOffset = Offset(0, 1);

  const CustomRadioButton({
    super.key,
    required this.onPressed,
    required this.dateOp,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Responsive.init(context: context);
    final viewModel = context.watch<AppointmentScreenVm>();

    final double containerSize = _getResponsiveContainerSize(context);
    final double iconSize = _getResponsiveIconSize(context);
    final bool isSelected = dateOp == viewModel.operation;

    return Padding(
      padding: const EdgeInsets.all(_marginSize),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.gray,
          ),
          child: Container(
            margin: EdgeInsets.all(_innerMargin),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : AppColors.gray,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: isSelected ? Colors.white : AppColors.gray,
                  blurRadius: _shadowBlurRadius,
                  spreadRadius: _shadowSpreadRadius,
                  offset: _shadowOffset,
                ),
              ],
            ),
            child: isSelected
                ? Center(
                    child: Icon(icon, size: iconSize, color: Colors.black),
                  )
                : null,
          ),
        ),
      ),
    );
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

  double _getResponsiveIconSize(BuildContext context) {
    if (Responsive.isTablet(context)) {
      return _tabletIconSize;
    } else if (Responsive.isDesktop(context)) {
      return _desktopIconSize;
    } else {
      return _mobileIconSize;
    }
  }
}

Future<void> _showCalendarDialog(
  BuildContext context,
  DateTime selectedDate,
  Function(DateTime) onDateSelected,
) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    helpText: 'Start Date',
    builder: (context, child) {
      // Optional: custom theme
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.black, // header background color
            onPrimary: Colors.white, // header text color
            onSurface: Colors.black, // body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black, // button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );

  if (picked != null && picked != selectedDate) {
    onDateSelected(picked);
  }
}
