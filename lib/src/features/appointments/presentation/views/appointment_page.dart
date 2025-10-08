import 'package:appo/src/features/appointments/presentation/widgets/appointment_title/appointment_title.dart';
import 'package:appo/src/features/appointments/presentation/widgets/buttons_panel/buttons_panel.dart';
import 'package:appo/src/features/appointments/presentation/widgets/period_display_card/period_display_card.dart';
import 'package:appo/src/features/appointments/presentation/widgets/selector/selector.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({super.key});

  static const double _sectionSpacing = 30.0;
  static const double _panelContentWidth = 0.8;
  static const double _titleContentWidth = 0.7;
  static const int _titleSectionFlex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAppointmentTitleSection(),
            _buildControlPanelSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlPanelSection() {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: _panelContentWidth,
          child: const Column(
            children: [
              PeriodDisplayCard(),
              SizedBox(height: _sectionSpacing),
              ButtonsPanel(),
            ],
          ),
        ),
        const SizedBox(height: _sectionSpacing),
        const SelectorPanel(),
      ],
    );
  }

  Widget _buildAppointmentTitleSection() {
    return Expanded(
      flex: _titleSectionFlex,
      child: FractionallySizedBox(
        widthFactor: _titleContentWidth,
        child: const AppointmentTitle(),
      ),
    );
  }
}
