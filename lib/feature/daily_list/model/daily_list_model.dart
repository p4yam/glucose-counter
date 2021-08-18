

class DailyListModel {
  final DateTime dateDay;
  final List<DateTime> dateTime;
  final List<int> glucoseValues;
  final int rangePercent;
  final int numPicks;

  DailyListModel(
      {this.dateDay, this.glucoseValues, this.numPicks, this.rangePercent,this.dateTime});
}
