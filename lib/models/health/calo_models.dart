class CaloDayData {
  CaloDayData(this._goal, this._caloIn, this._caloOut);

  final int _goal;
  final List<CaloIn> _caloIn;
  final List<CaloOut> _caloOut;

  int getGoal() => _goal;

  int getCaloIn() {
    int result = 0;
    for (CaloIn x in _caloIn) result += x.getCalo();
    return result;
  }

  int getCaloOut() {
    int result = 0;
    for (CaloOut x in _caloOut) result += x.getCalo();
    return result;
  }
}

class CaloIn {
  CaloIn(this.time, this.name, this.servingCalo, this.serving);

  final DateTime time;
  final String name;
  final int servingCalo;
  final double serving;

  int getCalo() => (servingCalo * serving).toInt();
}

class CaloOut {
  CaloOut(this.time, this.name, this.servingCalo, this.serving);

  final DateTime time;
  final String name;
  final int servingCalo;
  final double serving;

  int getCalo() => (servingCalo * serving).toInt();
}
