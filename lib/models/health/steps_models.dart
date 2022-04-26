class StepsDayData {
  StepsDayData(this._goal, this._record);

  final int _goal;
  final List<Steps> _record;

  int getGoal() => _goal;

  List<Steps> getSteps() => _record;

  int getStepsValue() {
    int value = 0;
    for (Steps x in _record) value += x.value;
    return value;
  }
}

class Steps {
  Steps(this.time, this.value);

  final DateTime time;
  final int value;
}

class StepsMonthReport {
  StepsMonthReport(this._steps, this._goalDay, this._day, this._data);

  final int _steps;
  final int _goalDay;
  final int _day;
  final List<StepsDayReportData> _data;

  int getSteps() => _steps;

  int getGoalDay() => _goalDay;

  int getDay() => _day;

  List<StepsDayReportData> getData() => _data;
}

class StepsYearReport {
  StepsYearReport(this._steps, this._data);

  final int _steps;
  final List<StepsMonthReportData> _data;

  int getSteps() => _steps;

  List<StepsMonthReportData> getData() => _data;

  int getAVGDay() {
    int totalSteps = 0;
    for (StepsMonthReportData x in _data)
      totalSteps += x.getSteps() * x.getDays();
    return totalSteps ~/ getTotalDay();
  }

  int getTotalDay() {
    int result = 0;
    for (StepsMonthReportData x in _data) result += x.getDays();
    return result;
  }

  int getTotalGoalDay() {
    int result = 0;
    for (StepsMonthReportData x in _data) result += x.getGoal();
    return result;
  }
}

class StepsDayReportData {
  StepsDayReportData(this._goal, this._steps);

  final int _goal;
  final int _steps;

  int getGoal() => _goal;

  int getSteps() => _steps;
}

class StepsMonthReportData {
  StepsMonthReportData(this._days, this._goalDay, this._avgSteps);

  final int _days;
  final int _goalDay;
  final int _avgSteps;

  int getDays() => _days;

  int getGoal() => _goalDay;

  int getSteps() => _avgSteps;
}
