import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/community/community_models.dart';


class AllCommunitiesState extends CubitState {
  AllCommunitiesState(this.allCommunities);

  final List<CommunityGroup> allCommunities;

  @override
  List<Object> get props => [allCommunities];
}
