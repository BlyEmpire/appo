enum TimeUnit {
  days(name: "days", intervals: [30, 7, 1, -1]),
  months(name: "months", intervals: [6, 3, 1, -1]),
  years(name: "years", intervals: [10, 5, 1, -1]);

  final String name;
  final List<int> intervals;

  const TimeUnit({required this.name, required this.intervals});
}
