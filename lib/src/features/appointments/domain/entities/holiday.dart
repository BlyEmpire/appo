class Holiday {
  final String _name;
  final DateTime _observedDate;

  String get name => _name;
  DateTime get date => _observedDate;

  Holiday({required String name, required DateTime observedDate})
    : _name = name,
      _observedDate = observedDate;
}

class ZambianHolidayService {
  /// Returns a map of holiday name to DateTime for the given year.
  // Map<String, DateTime> getHolidays(int year) {
  List<Holiday> getHolidays(int year) {
    final holidays = <String, DateTime>{};

    // Fixed holidays
    holidays["New Year's Day"] = DateTime(year, 1, 1);
    holidays["International Women's Day"] = DateTime(year, 3, 8);
    holidays["Kenneth Kaunda Day"] = DateTime(year, 4, 28);
    holidays["Labour Day"] = DateTime(year, 5, 1);
    holidays["Africa Freedom Day"] = DateTime(year, 5, 25);
    holidays["Independence Day"] = DateTime(year, 10, 24);
    holidays["National Prayer Day"] = DateTime(year, 10, 18);
    holidays["Christmas Day"] = DateTime(year, 12, 25);
    holidays["Boxing Day"] = DateTime(year, 12, 26);

    // Movable holidays (Easter)
    final easterSunday = _calculateEasterSunday(year);
    holidays["Good Friday"] = easterSunday.subtract(const Duration(days: 2));
    holidays["Easter Monday"] = easterSunday.add(const Duration(days: 1));

    // Movable holidays (Heroes & Unity Day)
    final heroesDay = _firstMondayOfJuly(year);
    holidays["Heroes Day"] = heroesDay;
    holidays["Unity Day"] = heroesDay.add(const Duration(days: 1));

    return holidays.entries.map((entry) {
      return Holiday(name: entry.key, observedDate: entry.value);
    }).toList();
  }

  /// Calculate Easter Sunday for a given year using the "Computus" algorithm
  DateTime _calculateEasterSunday(int year) {
    // Meeus/Jones/Butcher algorithm
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  /// Find the first Monday of July for Heroes Day
  DateTime _firstMondayOfJuly(int year) {
    DateTime date = DateTime(year, 7, 1);
    while (date.weekday != DateTime.monday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }
}
