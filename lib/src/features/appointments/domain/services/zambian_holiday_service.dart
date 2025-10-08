import 'package:appo/src/features/appointments/domain/entities/holiday.dart';

/// Service to provide a list of official Zambian public holidays for a given year.
///
/// This includes:
/// - Fixed-date holidays (e.g., New Year's Day, Independence Day)
/// - Movable holidays based on Easter (Good Friday, Easter Monday)
/// - Movable holidays based on rules (Heroes Day & Unity Day)
class ZambianHolidayService {
  /// Returns a list of [Holiday] objects representing Zambian public holidays
  /// for the specified [year].
  List<Holiday> getHolidays(int year) {
    final Map<String, DateTime> holidays = {};

    // -----------------------------
    // Fixed-date holidays
    // -----------------------------
    holidays.addAll({
      "New Year's Day": DateTime(year, 1, 1),
      "International Women's Day": DateTime(year, 3, 8),
      "Kenneth Kaunda Day": DateTime(year, 4, 28),
      "Labour Day": DateTime(year, 5, 1),
      "Africa Freedom Day": DateTime(year, 5, 25),
      "National Prayer Day": DateTime(year, 10, 18),
      "Independence Day": DateTime(year, 10, 24),
      "Christmas Day": DateTime(year, 12, 25),
      "Boxing Day": DateTime(year, 12, 26),
    });

    // -----------------------------
    // Movable holidays based on Easter
    // -----------------------------
    final DateTime easterSunday = _calculateEasterSunday(year);
    holidays["Good Friday"] = easterSunday.subtract(const Duration(days: 2));
    holidays["Easter Monday"] = easterSunday.add(const Duration(days: 1));

    // -----------------------------
    // Movable holidays based on rules (Heroes Day & Unity Day)
    // -----------------------------
    final DateTime heroesDay = _firstMondayOfJuly(year);
    holidays["Heroes Day"] = heroesDay;
    holidays["Unity Day"] = heroesDay.add(const Duration(days: 1));

    // Convert Map to List<Holiday>
    return holidays.entries
        .map((entry) => Holiday(name: entry.key, observedDate: entry.value))
        .toList();
  }

  // --------------------------------------------------------------------------
  // Private helper methods
  // --------------------------------------------------------------------------

  /// Calculates the date of Easter Sunday for a given [year] using the
  /// Meeus/Jones/Butcher algorithm.
  DateTime _calculateEasterSunday(int year) {
    final int a = year % 19;
    final int b = year ~/ 100;
    final int c = year % 100;
    final int d = b ~/ 4;
    final int e = b % 4;
    final int f = (b + 8) ~/ 25;
    final int g = (b - f + 1) ~/ 3;
    final int h = (19 * a + b - d - g + 15) % 30;
    final int i = c ~/ 4;
    final int k = c % 4;
    final int l = (32 + 2 * e + 2 * i - h - k) % 7;
    final int m = (a + 11 * h + 22 * l) ~/ 451;
    final int month = (h + l - 7 * m + 114) ~/ 31;
    final int day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  /// Finds the first Monday of July for a given [year].
  /// This is used to calculate Heroes Day and Unity Day.
  DateTime _firstMondayOfJuly(int year) {
    DateTime date = DateTime(year, 7, 1);
    while (date.weekday != DateTime.monday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }
}
