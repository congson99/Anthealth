import 'package:anthealth_mobile/models/medic/medical_directory_models.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:tiengviet/tiengviet.dart';

class MedicalDirectoryLogic {
  static List<MedicalDirectoryAlphabetMarkData> formatToMaskList(
      List<MedicalDirectoryData> data) {
    List<MedicalDirectoryAlphabetMarkData> result = [];
    if (data.length == 0) return result;
    result.add(
        MedicalDirectoryAlphabetMarkData(0, true, data[0].getName(), "", ""));
    if (data.length == 1) return result;
    for (int i = 1; i < data.length; i++) {
      if (data[i].getName().substring(0, 1).toUpperCase() ==
          data[i - 1].getName().substring(0, 1).toUpperCase())
        result.add(MedicalDirectoryAlphabetMarkData(
            i, false, data[i].getName(), "", ""));
      else
        result.add(MedicalDirectoryAlphabetMarkData(
            i, true, data[i].getName(), "", ""));
    }
    return result;
  }

  static List<MedicalDirectoryAlphabetMarkData> formatMedicationToMaskList(
      List<MedicineData> data) {
    List<MedicalDirectoryAlphabetMarkData> result = [];
    if (data.length == 0) return result;
    result.add(
        MedicalDirectoryAlphabetMarkData(0, true, data[0].getName(), "", ""));
    if (data.length == 1) return result;
    for (int i = 1; i < data.length; i++) {
      if (data[i].getName().substring(0, 1).toUpperCase() ==
          data[i - 1].getName().substring(0, 1).toUpperCase())
        result.add(MedicalDirectoryAlphabetMarkData(
            i, false, data[i].getName(), "", ""));
      else
        result.add(MedicalDirectoryAlphabetMarkData(
            i, true, data[i].getName(), "", ""));
    }
    return result;
  }

  static List<MedicalDirectoryAlphabetMarkData> highlight(
      List<MedicalDirectoryAlphabetMarkData> source, String keyword) {
    List<MedicalDirectoryAlphabetMarkData> result = [];
    for (MedicalDirectoryAlphabetMarkData x in source) {
      int index = TiengViet.parse(x.name)
          .toLowerCase()
          .indexOf(TiengViet.parse(keyword).toLowerCase());
      String front = "";
      if (index != 0) front = x.name.substring(0, index);
      String highlight = x.name.substring(index, index + keyword.length);
      String behind = "";
      if (index != x.name.length - 1)
        behind = x.name.substring(index + keyword.length);
      result.add(MedicalDirectoryAlphabetMarkData(
          x.index, x.mark, front, highlight, behind));
    }
    return result;
  }

  static List<MedicalDirectoryAlphabetMarkData> filter(
      List<MedicalDirectoryData> data, String keyword) {
    List<MedicalDirectoryAlphabetMarkData> source =
        MedicalDirectoryLogic.formatToMaskList(data);
    List<MedicalDirectoryAlphabetMarkData> result = [];
    for (MedicalDirectoryAlphabetMarkData x in source)
      if (TiengViet.parse(x.name)
          .toLowerCase()
          .contains(TiengViet.parse(keyword).toLowerCase())) {
        MedicalDirectoryAlphabetMarkData temp = x;
        if (result.length == 0 ||
            temp.name.substring(0, 1).toLowerCase() !=
                result.last.name.substring(0, 1).toLowerCase())
          temp.mark = true;
        result.add(temp);
      }
    return MedicalDirectoryLogic.highlight(result, keyword);
  }

  static List<MedicalDirectoryAlphabetMarkData> medicationFilter(
      List<MedicineData> data, String keyword) {
    List<MedicalDirectoryAlphabetMarkData> source =
        MedicalDirectoryLogic.formatMedicationToMaskList(data);
    List<MedicalDirectoryAlphabetMarkData> result = [];
    for (MedicalDirectoryAlphabetMarkData x in source)
      if (TiengViet.parse(x.name)
          .toLowerCase()
          .contains(TiengViet.parse(keyword).toLowerCase())) {
        MedicalDirectoryAlphabetMarkData temp = x;
        if (result.length == 0 ||
            temp.name.substring(0, 1).toLowerCase() !=
                result.last.name.substring(0, 1).toLowerCase())
          temp.mark = true;
        result.add(temp);
      }
    return MedicalDirectoryLogic.highlight(result, keyword);
  }
}

class MedicalDirectoryAlphabetMarkData {
  MedicalDirectoryAlphabetMarkData(
      this.index, this.mark, this.name, this.highlight, this.subName);

  int index;
  bool mark;
  String name;
  String highlight;
  String subName;
}
