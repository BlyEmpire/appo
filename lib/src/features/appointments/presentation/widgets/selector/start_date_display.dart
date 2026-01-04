import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:appo/src/features/appointments/presentation/view_models/show_calender_view_model.dart';
import 'package:appo/src/features/appointments/presentation/widgets/calender_widget/custom_calender.dart';
import 'package:appo/src/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Displays the current start date and allows the user to open a calendar dialog
/// to select a new date.
class StartDateDisplay extends StatelessWidget {
  const StartDateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.uiBuilder.isMobile;

    return InkWell(
      onTap: () {
        isMobile
            ? showModalBottomSheet(
                context: context,
                elevation: 4.0,
                clipBehavior: Clip.antiAlias,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.vertical(
                    top: Radius.circular(20.0),
                  ),
                  side: BorderSide(color: Colors.black, width: 2.0),
                ),
                builder: (_) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(color: AppColors.textPrimary),
                  width: double.infinity,

                  child: const CustomCal(),
                ),
              )
            : showDialog(
                context: context,
                builder: (_) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(12.0),
                      ),
                      side: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    child: Container(
                      width: 500,
                      height: 650,
                      padding: EdgeInsets.all(16.0),
                      child: const CustomCal(),
                    ),
                  );
                },
              );
      },
      child: const _BuildStartDateText(),
    );
  }
}

class _BuildStartDateText extends StatelessWidget {
  const _BuildStartDateText();

  @override
  Widget build(BuildContext context) {
    final uiBuilder = context.uiBuilder;
    // final vm = context.read<CalculatedDateViewModel>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Start Date", style: uiBuilder.startDateString),

        // Text(vm.startDate.formattedStringDate(), style: uiBuilder.startDate),
        Selector<ShowCalenderViewModel, DateTime>(
          builder: (_, newDate, __) {
            return Text(
              newDate.formattedStringDate(),
              style: uiBuilder.startDate,
            );
          },
          selector: (_, vm) => vm.selectedDate,
        ),
      ],
    );
  }
}

class CustomCal extends StatelessWidget {
  const CustomCal({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleCalendarPicker(
      initialDate: DateTime.now(),
      onDateSelected: (date) {
        Navigator.pop(context);
      },
    );
  }
}
