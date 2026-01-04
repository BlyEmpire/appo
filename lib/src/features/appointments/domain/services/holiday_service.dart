import 'package:appo/src/features/appointments/domain/entities/holiday.dart';

class HolidayRepository {
  Map<DateTime, Holiday> _cachedHolidays = {};
  int? _cachedYear;

  Holiday? findHolidayInYear({required DateTime date}) {
    final year = date.year;
    _ensureHolidaysCached(year: year);

    if (_cachedHolidays.containsKey(_normalizeDate(date: date))) {
      return _cachedHolidays[_normalizeDate(date: date)];
    }

    return null;
  }

  void clearCache() {
    _cachedHolidays = {};
    _cachedYear = null;
  }

  Map<DateTime, Holiday> getZambianHolidays({required int year}) {
    final Map<DateTime, Holiday> holidays = {};

    holidays.addAll({
      DateTime(year, 1, 1): Holiday(
        name: "New Year's Day",
        observedDate: DateTime(year, 1, 1),
      ),
      DateTime(year, 3, 8): Holiday(
        name: "International Women's Day",
        observedDate: DateTime(year, 3, 8),
      ),
      DateTime(year, 4, 28): Holiday(
        name: "Kenneth Kaunda Day",
        observedDate: DateTime(year, 4, 28),
      ),
      DateTime(year, 5, 1): Holiday(
        name: "Labour Day",
        observedDate: DateTime(year, 5, 1),
      ),
      DateTime(year, 5, 25): Holiday(
        name: "Africa Freedom Day",
        observedDate: DateTime(year, 5, 25),
      ),
      DateTime(year, 10, 18): Holiday(
        name: "National Prayer Day",
        observedDate: DateTime(year, 10, 18),
      ),
      DateTime(year, 10, 24): Holiday(
        name: "Independence Day",
        observedDate: DateTime(year, 10, 24),
      ),
      DateTime(year, 12, 25): Holiday(
        name: "Christmas Day",
        observedDate: DateTime(year, 12, 25),
      ),
      DateTime(year, 12, 26): Holiday(
        name: "Boxing Day",
        observedDate: DateTime(year, 12, 26),
      ),
    });

    final DateTime easterSunday = _calculateEasterSunday(year);
    final normalizeGoodFriday = _normalizeDate(
      date: easterSunday.subtract(const Duration(days: 2)),
    );
    final normalizeEasterMonday = _normalizeDate(
      date: easterSunday.add(const Duration(days: 1)),
    );
    holidays[normalizeGoodFriday] = Holiday(
      name: "Good Friday",
      observedDate: normalizeGoodFriday,
    );
    holidays[normalizeEasterMonday] = Holiday(
      name: "Easter Monday",
      observedDate: normalizeEasterMonday,
    );

    // -----------------------------
    // Movable holidays based on rules (Heroes Day & Unity Day)
    // -----------------------------
    final DateTime heroesDay = _firstMondayOfJuly(year);
    final normalizedHeroesDay = _normalizeDate(date: heroesDay);
    final normalizedUnityDay = _normalizeDate(
      date: heroesDay.add(const Duration(days: 1)),
    );
    holidays[normalizedHeroesDay] = Holiday(
      name: "Heroes Day",
      observedDate: normalizedHeroesDay,
    );
    holidays[normalizedUnityDay] = Holiday(
      name: "Unity Day",
      observedDate: normalizedUnityDay,
    );

    return holidays;
  }

  // --------------------------------------------------------------------------
  // Private helper methods
  // --------------------------------------------------------------------------

  void _ensureHolidaysCached({required int year}) {
    if (_cachedYear != year || _cachedHolidays.isEmpty) {
      _cachedHolidays = getZambianHolidays(year: year);
      _cachedYear = year;
    }
  }

  // Normalize the date
  DateTime _normalizeDate({required DateTime date}) {
    return DateTime(date.year, date.month, date.day);
  }

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
