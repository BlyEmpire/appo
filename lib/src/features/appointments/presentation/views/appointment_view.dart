import 'package:appo/src/core/utils/responsive.dart';
import 'package:appo/src/features/appointments/presentation/widgets/appointment_buttons_grid.dart';
import 'package:appo/src/features/appointments/presentation/widgets/appointment_title.dart';
import 'package:flutter/material.dart';

class AppointmentView extends StatelessWidget {
  const AppointmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: AppointmentViewMobileLayout(),
          tablet: AppointmentViewTabletLayout(),
          desktop: AppointmentViewDesktopLayout(),
        ),
      ),
    );
  }
}

class AppointmentViewMobileLayout extends StatelessWidget {
  const AppointmentViewMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(flex: 1, child: AppointmentTitle()),
        Expanded(flex: 2, child: AppointmentButtonsGrid()),
      ],
    );
  }
}

class AppointmentViewTabletLayout extends StatelessWidget {
  const AppointmentViewTabletLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text("Tablet View"))),
    );
  }
}

class AppointmentViewDesktopLayout extends StatelessWidget {
  const AppointmentViewDesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: Text("Desktop View"))),
    );
  }
}
