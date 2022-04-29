import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/community/post_models.dart';


class CommunitiesPostPageState extends CubitState {
  CommunitiesPostPageState(this.allPost);

  final List<Post> allPost;

  @override
  List<Object> get props => [allPost];
}
