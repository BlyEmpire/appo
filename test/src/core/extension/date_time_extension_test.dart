import 'package:appo/src/core/extension/date_time_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Given day, when added to a date, then return the next date", () {
    // arrange
    int days = 16;
    DateTime today = DateTime(2025, 8, 16);

    // act
    final nextDate = today.findNextDate(days: days);

    // assert
    expect(nextDate, DateTime(2025, 9, 1));
  });
}
