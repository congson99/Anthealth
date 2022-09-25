class CaloDayData {
  CaloDayData(this.goal, this.caloIn, this.caloOut);

  int goal;
  List<CaloIn> caloIn;
  List<CaloOut> caloOut;

  int getGoal() => goal;

  List<CaloIn> getListCaloIn() => caloIn;

  List<CaloOut> getListCaloOut() => caloOut;

  int getCaloIn() {
    int result = 0;
    for (CaloIn x in caloIn) result += x.getCalo();
    return result;
  }

  int getCaloOut() {
    int result = 0;
    for (CaloOut x in caloOut) result += x.getCalo();
    return result;
  }
}

class CaloIn {
  CaloIn(this.id, this.time, this.name, this.servingName, this.servingCalo,
      this.serving);

  final String id;
  final DateTime time;
  final String name;
  final String servingName;
  final int servingCalo;
  double serving;

  int getCalo() => (servingCalo * serving).toInt();
}

class CaloOut {
  CaloOut(this.id, this.time, this.name, this.unitCalo, this.min);

  final String id;
  final DateTime time;
  final String name;
  final int unitCalo;
  int min;

  int getCalo() => (unitCalo * min).toInt();
}

class CaloDayReportData {
  CaloDayReportData(this.goal, this.caloIn, this.caloOut);

  final int goal;
  final int caloIn;
  final int caloOut;
}

class CaloMonthReportData {
  CaloMonthReportData(this.avgCaloIn, this.avgCaloOut);

  final int avgCaloIn;
  final int avgCaloOut;
}
