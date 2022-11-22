//

extension AppDates on DateTime {
  static DateTime get firstOfCurrent {
    return DateTime(DateTime.now().year, DateTime.now().month, 1);
  }
}
