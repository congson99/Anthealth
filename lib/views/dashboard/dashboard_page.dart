import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/loading_page.dart';
import 'package:anthealth_mobile/views/common_widgets/bottom_navigation.dart';
import 'package:anthealth_mobile/views/family/family_page.dart';
import 'package:anthealth_mobile/views/health/health_page.dart';
import 'package:anthealth_mobile/views/home/home_page.dart';
import 'package:anthealth_mobile/views/medic/medic_page.dart';
import 'package:anthealth_mobile/views/settings/sttings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) => BlocProvider<DashboardCubit>(
      create: (context) => DashboardCubit(),
      child: BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
        if (state is DoctorLoadingState) return LoadingPage();

        return Scaffold(
            body: SafeArea(
                child: Stack(children: [
          buildContent(state, context),
          buildBottomNavigation(context, state)
        ])));
      }));

  Widget buildContent(CubitState state, BuildContext context) {
    if (state is HomeState) return HomePage(user: user);
    if (state is HealthState) return HealthPage(user: user);
    if (state is MedicState) return MedicPage(user: user);
    if (state is FamilyState) return FamilyPage(user: user);
    if (state is SettingsState)
      return NewSettingsPage(
        user: user,
        lang: '',
      );
    return LoadingPage();
  }

  Widget buildBottomNavigation(BuildContext context, CubitState state) {
    return BottomNavigation(
        size: MediaQuery.of(context).size,
        index: currentIndexState(state),
        imagePath: user.avatarPath,
        onIndexChange: (int index) =>
            onBottomNavigationItemTap(context, index, state));
  }

  // Hepper Function
  void onBottomNavigationItemTap(
      BuildContext context, int index, CubitState state) {
    if (currentIndexState(state) == index) return;
    if (index == 0) BlocProvider.of<DashboardCubit>(context).health();
    if (index == 1) BlocProvider.of<DashboardCubit>(context).medic();
    if (index == 2) BlocProvider.of<DashboardCubit>(context).home();
    if (index == 3) BlocProvider.of<DashboardCubit>(context).family();
    if (index == 4) BlocProvider.of<DashboardCubit>(context).settings();
  }

  int currentIndexState(CubitState state) {
    if (state is FamilyState) return 3;
    if (state is SettingsState) return 4;
    if (state is HomeState) return 2;
    if (state is HealthState) return 0;
    if (state is MedicState) return 1;
    if (state is FamilyLoadingState) return 3;
    if (state is SettingsLoadingState) return 4;
    if (state is HomeLoadingState) return 2;
    if (state is HealthLoadingState) return 0;
    if (state is MedicLoadingState) return 1;
    return 2;
  }
}
