import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/community/community_post_page_state.dart';
import 'package:anthealth_mobile/logics/server_logic.dart';
import 'package:anthealth_mobile/models/community/post_models.dart';
import 'package:anthealth_mobile/models/medic/medical_record_models.dart';
import 'package:anthealth_mobile/services/message/message_id_path.dart';
import 'package:anthealth_mobile/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunitiesPostPageCubit extends Cubit<CubitState> {
  CommunitiesPostPageCubit(String id) : super(InitialState()) {
    loadData(id);
  }

  void loadedData(CommunitiesPostPageState state) {
    emit(CommunitiesPostPageState(state.allPost));
  }

  void loadData(String id) {
    loadedData(CommunitiesPostPageState([]));
  }

  /// Server Functions
  List<Post> loadMorePost(String communityID, [String? lastPost]) {
    if (lastPost == null)
      return [
        Post(
            "",
            PostAuthor(
                "",
                "Huong",
                "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
                DateTime.now()),
            [],
            [],
            true,
            "22",
            [],
            "",
            PostAuthor(
                "",
                "Hung",
                "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
                DateTime.now())),
        Post(
            "",
            PostAuthor(
                "",
                "Tra",
                "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
                DateTime.now()),
            [],
            [],
            false,
            "1",
            [],
            "",
            PostAuthor(
                "",
                "Hung",
                "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
                DateTime.now())),
        Post(
            "",
            PostAuthor(
                "",
                "Nam",
                "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
                DateTime.now()),
            [],
            [],
            true,
            "2",
            [],
            ""),
        Post(
            "",
            PostAuthor(
                "",
                "Anh",
                "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
                DateTime.now()),
            [],
            [],
            true,
            "3",
            [],
            "")
      ];
    if (lastPost == "hehe") return [];
    return [
      Post(
          "",
          PostAuthor(
              "",
              "Huong",
              "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
              DateTime.now()),
          [],
          [],
          true,
          "22",
          [],
          "",
          PostAuthor(
              "",
              "Hung",
              "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
              DateTime.now())),
      Post(
          "",
          PostAuthor(
              "",
              "Tra",
              "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
              DateTime.now()),
          [],
          [],
          false,
          "1",
          [],
          "",
          PostAuthor(
              "",
              "Hung",
              "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
              DateTime.now())),
      Post(
          "",
          PostAuthor(
              "",
              "Nam",
              "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
              DateTime.now()),
          [],
          [],
          true,
          "2",
          [],
          ""),
      Post(
          "hehe",
          PostAuthor(
              "",
              "Anh",
              "https://kenh14cdn.com/thumb_w/660/2020/10/12/3a7e4050-4f5d-4516-b9d7-1ec600e2d404-16025053985191348178238.jpeg",
              DateTime.now()),
          [],
          [],
          true,
          "3",
          [],
          "")
    ];
  }

  Future<bool> likePost(String communityID, String postID) async {
    return true;
  }

  Future<List<MedicalRecordYearLabel>> getMedicalRecord() async {
    List<MedicalRecordYearLabel> result = [];
    await CommonService.instance
        .send(MessageIDPath.getMedicalRecordPageData(), "");
    await CommonService.instance.client!.getData().then((value) {
      if (ServerLogic.checkMatchMessageID(
          MessageIDPath.getMedicalRecordPageData(), value)) {
        result = MedicalRecordPageData.formatData(
                ServerLogic.getData(value)["listRecord"],
                ServerLogic.getData(value)["listAppointment"])
            .listYearLabel;
      }
    });
    return result;
  }
}
