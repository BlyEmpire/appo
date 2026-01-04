import 'package:appo/src/core/extension/build_context_extension.dart';
import 'package:appo/src/features/appointments/presentation/view_models/calculated_date_view_model.dart';
import 'package:appo/src/features/appointments/presentation/widgets/appointment_title/week_list.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentTitle extends StatelessWidget {
  const AppointmentTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_BuildWeekDayList(), _BuildTitleText()],
    );
  }
}

class _BuildTitleText extends StatelessWidget {
  const _BuildTitleText();

  @override
  Widget build(BuildContext context) {
    final ui = context.uiBuilder;
    return Selector<CalculatedDateViewModel, _DateDate>(
      builder: (_, dateData, __) => Text(
        dateData.date,
        style: ui.headerStyle(isWeekend: dateData.isWeekend),
      ),
      selector: (_, vm) => _DateDate(
        isWeekend: vm.isCurrentDateWeekend,
        date: vm.appointmentDate,
      ),
    );
  }
}

class _BuildWeekDayList extends StatelessWidget {
  const _BuildWeekDayList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Selector<CalculatedDateViewModel, List<DateTime>>(
          builder: (_, weekDays, __) => WeekDayList(weekDays: weekDays),
          selector: (_, vm) => vm.weeksDay,
        ),
      ),
    );
  }
}

@immutable
class _DateDate extends Equatable {
  final bool isWeekend;
  final String date;

  const _DateDate({required this.isWeekend, required this.date});

  @override
  List<Object?> get props => [isWeekend, date];
}
