import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:appo/src/features/appointments/presentation/views/appointment_view.dart';
import 'package:appo/src/locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setup();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<AppointmentScreenVm>()),
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
      home: AppointmentView(),
    );
  }
}
