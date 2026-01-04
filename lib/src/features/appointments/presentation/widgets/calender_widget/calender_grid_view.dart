import 'package:appo/src/features/appointments/presentation/view_models/calculated_date_view_model.dart';
import 'package:appo/src/features/appointments/presentation/view_models/show_calender_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalenderGridView extends StatelessWidget {
  const CalenderGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final monthDays = context.select<ShowCalenderViewModel, List<DateTime?>>(
      (e) => e.precomputedDays,
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: 42,
      itemBuilder: (context, index) {
        final dayItemValue = monthDays[index];
        if (dayItemValue == null) return Container();
        return CalenderDayItem(
          date: dayItemValue,
          onPressed: (newDate) {
            //  update the selected date in the calculated date view model
            // context.read<CalculatedDateViewModel>().updateStartDate(
            //   newDate: newDate,
            // );
            context.read<ShowCalenderViewModel>().pickDateOnCalender(
              pickedDate: newDate,
            );
            // load the selected date
            final selectedDate = context
                .read<ShowCalenderViewModel>()
                .selectedDate;

            // calculate the new appointment date based on the selected date
            context.read<CalculatedDateViewModel>().calculateDate(
              startDate: selectedDate,
            );
          },
        );
      },
    );
  }
}

class CalenderDayItem extends StatelessWidget {
  const CalenderDayItem({super.key, required this.date, this.onPressed});

  final DateTime date;
  final ValueChanged<DateTime>? onPressed;

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size.width;
    final fontSize = query < 600 ? 14.0 : 18.0;
    return GestureDetector(
      onTap: () {
        onPressed?.call(date);
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Center(
          child: Text("${date.day}", style: TextStyle(fontSize: fontSize)),
        ),
      ),
    );
  }
}
