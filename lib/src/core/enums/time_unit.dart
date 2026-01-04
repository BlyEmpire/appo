enum DateOperation { add, subtract }

enum TimeUnit {
  days(name: "Days", intervals: [30, 7, 1, -1]),
  months(name: "Months", intervals: [6, 3, 1, -1]),
  years(name: "Years", intervals: [10, 5, 1, -1]);

  final String name;
  final List<int> intervals;

  const TimeUnit({required this.name, required this.intervals});
}
