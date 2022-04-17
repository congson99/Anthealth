import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';

class MedicalDirectoryLogic {
  static List<MedicalDirectoryAlphabetMarkData> formatToMaskList(
      List<MedicalDirectoryData> data) {
    List<MedicalDirectoryAlphabetMarkData> result = [];
    if (data.length == 0) return result;
    result.add(MedicalDirectoryAlphabetMarkData(0, true, data[0].getName()));
    if (data.length == 1) return result;
    for (int i = 1; i < data.length; i++) {
      if (data[i].getName().substring(0, 1).toUpperCase() ==
          data[i - 1].getName().substring(0, 1).toUpperCase())
        result
            .add(MedicalDirectoryAlphabetMarkData(i, false, data[i].getName()));
      else
        result
            .add(MedicalDirectoryAlphabetMarkData(i, true, data[i].getName()));
    }
    return result;
  }
}

class MedicalDirectoryAlphabetMarkData {
  MedicalDirectoryAlphabetMarkData(this.index, this._mark, this._name);

  final int index;
  final bool _mark;
  final String _name;

  bool getMark() => _mark;

  String getName() => _name;
}
