import 'package:appo/src/features/appointments/presentation/widgets/appointment_title/appointment_title.dart';
import 'package:appo/src/features/appointments/presentation/widgets/buttons_panel/buttons_panel.dart';
import 'package:appo/src/features/appointments/presentation/widgets/period_display_card/period_display_card.dart';
import 'package:appo/src/features/appointments/presentation/widgets/selector/selector.dart';
import 'package:appo/src/shared/shared.dart';
import 'package:flutter/material.dart';

/// The Appointment screen is the entry point for the app and is divided into 3 sections:
///
/// - `AppointmentTitle`: Displays the calculated appointment date, including surrounding weekdays.
/// - `PeriodDisplayCard`: Displays the days, months, and years used to calculate the appointment date.
/// - `ButtonsPanel`: Contains buttons to modify the number of days, months, or years added or subtracted from the start date to compute the next appointment.
/// - `SelectorPanel`: Provides addition and subtraction operators to select past or future dates. Also allows modifying the start date.

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.textPrimary,
      body: SafeArea(
        child: Column(
          spacing: 10.0,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: AppointmentTitle()),
            PeriodDisplayCard(),
            ButtonsPanel(),
            SelectorPanel(),
          ],
        ),
      ),
    );
  }
}
