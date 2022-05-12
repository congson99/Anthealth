import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/community/community_post_page_state.dart';
import 'package:anthealth_mobile/models/community/post_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommunitiesPostPageCubit extends Cubit<CubitState> {
  CommunitiesPostPageCubit(String id) : super(InitialState()) {
    loadData(id);
  }

  void loadedData(CommunitiesPostPageState state) {
    emit(CommunitiesPostPageState(state.allPost));
  }

  List<Post> loadMorePost(
      ){
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
          [],"",
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
          [],"",
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
          [],""),
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
          [],"")
    ];
  }

  void loadData(String id) {
    loadedData(CommunitiesPostPageState([]));
  }
}
