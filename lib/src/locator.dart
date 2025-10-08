import 'package:appo/src/features/appointments/domain/services/zambian_holiday_service.dart';
import 'package:appo/src/features/appointments/presentation/view_models/appointment_screen_vm.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<ZambianHolidayService>(
    () => ZambianHolidayService(),
  );

  locator.registerFactory<AppointmentScreenVm>(
    () => AppointmentScreenVm(zambianHolidayService: locator()),
  );
}
