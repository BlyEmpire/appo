import 'package:appo/src/features/appointments/presentation/view_models/calculated_date_view_model.dart';
import 'package:appo/src/features/appointments/presentation/view_models/panel_manager.dart';
import 'package:appo/src/features/appointments/presentation/view_models/selector_view_model.dart';
import 'package:appo/src/features/appointments/presentation/view_models/show_calender_view_model.dart';
import 'package:appo/src/features/appointments/presentation/views/appointment_screen.dart';
import 'package:appo/src/shared/shared.dart';
import 'package:appo/src/shared/ui_builder/ui_builder_inherited.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectorViewModel()),
        ChangeNotifierProvider(create: (_) => PanelManager()),
        ChangeNotifierProvider(create: (_) => CalculatedDateViewModel()),
        ChangeNotifierProvider(create: (_) => ShowCalenderViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          return UI(
            builder: UIBuilder(constraints: constraints),
            child: const AppointmentScreen(),
          );
        },
      ),
    );
  }
}
