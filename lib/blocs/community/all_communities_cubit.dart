import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/community/all_communities_states.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCommunitiesCubit extends Cubit<CubitState> {
  AllCommunitiesCubit() : super(InitialState()) {
    loadData();
  }

  void loadedData(AllCommunitiesState state) {
    emit(AllCommunitiesState(state.allCommunities));
  }

  void updateOpening(AllCommunitiesState state, int index) {
    emit(InitialState());
    for (CommunityGroup x in state.allCommunities) {
      if (x == state.allCommunities[index]) {
        x.isOpening = !x.isOpening;
        continue;
      }
      x.isOpening = false;
    }
    loadedData(state);
  }

  void loadData() {
    emit(InitialState());
    loadedData(AllCommunitiesState([
      CommunityGroup(
          "",
          [
            CommunityData(
                '0',
                "Yoga",
                "Yoga a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                "https://www.victoriavn.com/images/healthlibrary/hatha-yoga.jpg",
                239,
                true, []),
            CommunityData(
                '0',
                "Make up",
                "Gys a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                "http://file.hstatic.net/1000379579/article/thuat-ngu-makeup-danh-cho-nguoi-moi-bat-dau_e9dc32edb93647c4aefea1807091100a.jpg",
                2883,
                true, [])
          ],
          false),
      CommunityGroup(
          "Sport",
          [
            CommunityData(
                '0',
                "Yoga",
                "Yoga a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                "https://www.victoriavn.com/images/healthlibrary/hatha-yoga.jpg",
                239,
                true, []),
            CommunityData(
                '0',
                "Gym",
                "Gys a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                "http://www.elleman.vn/wp-content/uploads/2017/04/13/Nuoc-hoa-nam-cho-phong-gym-1.jpg",
                2883,
                false, [])
          ],
          false),
      CommunityGroup(
          "Women",
          [
            CommunityData(
                '0',
                "Skin care",
                "Yoga a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                "http://imc.net.vn/wp-content/uploads/2021/03/imc-skincare.jpg",
                239,
                false, []),
            CommunityData(
                '0',
                "Make up",
                "Gys a ha ha ehe he asida sndna dasd sadasd a das d asd as das d asd as d asnd asdnsandasndnad as d asd an dna nd",
                "http://file.hstatic.net/1000379579/article/thuat-ngu-makeup-danh-cho-nguoi-moi-bat-dau_e9dc32edb93647c4aefea1807091100a.jpg",
                2883,
                true, [])
          ],
          false)
    ]));
  }
}
