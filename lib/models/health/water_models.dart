class WaterDayData {
  WaterDayData(this.goal, this.record);

  int goal;
  List<Water> record;

  int getGoal() => goal;

  List<Water> getWater() => record;

  int getWaterValue() {
    int value = 0;
    for (Water x in record) value += x.value;
    return value;
  }
}

class Water {
  Water(this.time, this.value);

  final DateTime time;
  final int value;
}

class WaterMonthReport {
  WaterMonthReport(this._goalDay, this._day, this._data);

  final int _goalDay;
  final int _day;
  final List<WaterDayReportData> _data;

  int getGoalDay() => _goalDay;

  int getDay() => _day;

  List<WaterDayReportData> getData() => _data;
}

class WaterYearReport {
  WaterYearReport(this._data);

  final List<WaterMonthReportData> _data;

  List<WaterMonthReportData> getData() => _data;

  int getAVGDay() {
    int totalWater = 0;
    for (WaterMonthReportData x in _data)
      totalWater += x.getDrink() * x.getDays();
    return totalWater ~/ getTotalDay();
  }

  int getTotalDay() {
    int result = 0;
    for (WaterMonthReportData x in _data) result += x.getDays();
    return result;
  }

  int getTotalGoalDay() {
    int result = 0;
    for (WaterMonthReportData x in _data) result += x.getGoal();
    return result;
  }
}

class WaterDayReportData {
  WaterDayReportData(this._goal, this._drink);

  final int _goal;
  final int _drink;

  int getGoal() => _goal;

  int getDrink() => _drink;
}

class WaterMonthReportData {
  WaterMonthReportData(this._days, this._goalDay, this._avgDrink);

  final int _days;
  final int _goalDay;
  final int _avgDrink;

  int getDays() => _days;

  int getGoal() => _goalDay;

  int getDrink() => _avgDrink;
}
