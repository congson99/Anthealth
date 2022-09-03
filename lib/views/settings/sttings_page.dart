import 'package:anthealth_mobile/blocs/app_cubit.dart';
import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_cubit.dart';
import 'package:anthealth_mobile/blocs/dashbord/dashboard_states.dart';
import 'package:anthealth_mobile/blocs/language/language_cubit.dart';
import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/post/post_models.dart';
import 'package:anthealth_mobile/models/user/user_models.dart';
import 'package:anthealth_mobile/views/common_pages/error_page.dart';
import 'package:anthealth_mobile/views/common_pages/template_dashboard_page.dart';
import 'package:anthealth_mobile/views/common_widgets/custom_divider.dart';
import 'package:anthealth_mobile/views/common_widgets/section_component.dart';
import 'package:anthealth_mobile/views/common_widgets/warning_popup.dart';
import 'package:anthealth_mobile/views/post/post_page.dart';
import 'package:anthealth_mobile/views/settings/general/setting_language_page.dart';
import 'package:anthealth_mobile/views/settings/settings_profile_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewSettingsPage extends StatelessWidget {
  const NewSettingsPage({Key? key, required this.user, required this.lang})
      : super(key: key);

  final User user;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, CubitState>(builder: (context, state) {
      if (state is SettingsState)
        return TemplateDashboardPage(
            title: S.of(context).Welcome,
            name: user.name,
            isHeader: false,
            content: buildContent(context));
      else
        return ErrorPage();
    });
  }

  Widget buildContent(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      buildUserInfo(context),
      buildGeneral(context),
      buildLogout(context),
    ]);
  }

  Widget buildUserInfo(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32),
        ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image.network(
              (user.avatarPath == "")
                  ? "https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png"
                  : user.avatarPath,
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover),
        ),
        SizedBox(height: 12),
        Text(user.name,
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: AnthealthColors.black1)),
        SizedBox(height: 32),
      ],
    );
  }

  Widget buildGeneral(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionComponent(
          title: S.of(context).Profile_info,
          colorID: 3,
          iconPath: "assets/app_icon/common/user_bla0.png",
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => SettingsProfilePage(
                    user: user,
                    appContext: context,
                  )))),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).Language,
          iconPath: "assets/app_icon/common/language_sec0.png",
          colorID: 1,
          onTap: () {
            getLanguage().then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => SettingLanguagePage(
                      languageID: value,
                      update: (result) {
                        BlocProvider.of<LanguageCubit>(context)
                            .updateLanguage(result, context);
                      })));
            });
          }),
      SizedBox(height: 16),
      SectionComponent(
          title: S.of(context).About_us,
          iconPath: "assets/app_icon/common/info_pri0.png",
          colorID: 0,
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => PostPage(
                      post: Post.generate(
                          postKey: "Về chúng tôi",
                          title:
                              "AntHealth - Ứng dụng chăm sóc sức khoẻ cá nhân và gia đình",
                          content: [
                        "https://scontent.xx.fbcdn.net/v/t1.15752-9/302381450_1703337536717281_3121546919142713676_n.png?_nc_cat=103&ccb=1-7&_nc_sid=aee45a&_nc_ohc=02FILl69XyAAX-zs84I&_nc_ad=z-m&_nc_cid=0&_nc_ht=scontent.xx&oh=03_AVI63yEGBjmQhKVC9KCX0dGDMeRLAttDU-dJdkArx6sN1w&oe=6338D39C",
                        "Ứng dụng là sản phẩm luận văn tốt nghiệp của trường Đại Học Bác Khoa- Đại học Quốc Gia Thành Phố Hồ Chí Minh.",
                        "Giảng viên hướng dẫn: cô Trần Thị Quế Ngyệt",
                        "Nhóm sinh viên thực hiện gồm:",
                        "- Hồ Công Sơn",
                        "- Trần Tiến Vũ",
                        "- Nguyễng Trương Đình Quân",
                        "",
                        "1. Động lực",
                        "Ngày nay, với diễn biến phức tạp của đại dịch COVID-19, nhu cầu về nhân lực và thiết bị y tế luôn trong tình trạng thiếu hụt. Trên thế giới, đã có rất nhiều trường hợp tử vong không chỉ vì nhiễm virus SARS-CoV-2 và còn vì các bệnh khác với nguyên do không được hỗ trợ y tế kịp thời. Trong tình cảnh cấp thiết đó, rất nhiều sản phẩm ứng dụng công nghệ đã ra đời nhằm hỗ trợ trực tiếp công cuộc chống dịch nói chung và nâng cao khả năng tự chăm sóc, bảo vệ bản thân nói riêng. Từ đó đem đến nhiều hiệu quả đáng kinh ngạc và thúc đẩy sự hỗ trợ về công nghệ mạnh mẽ hơn nữa để cải thiện tình hình y tế.",
                        "Với động lực to lớn trên và tinh thần trách nhiệm đóng góp cho cộng đồng của những người làm công nghệ nói chung và trường Đại Học Bách Khoa Tp.HCM nói riêng. Dựa trên tình hình thực thế và thói quen sử dụng công nghệ của người dân, nhóm đã lựa chọn phát triển sản phẩm hỗ trợ theo dõi và chăm sóc sức khoẻ với các tính năng có thể giải quyết được nhiều vấn đề khó khăn hiện tại và hỗ trợ phần nào các y bác sĩ trong công cuộc chống dịch.",
                        "",
                        "2. Mục tiêu đề tài",
                        "Với nhu cầu xã hội và các vấn đề khó khăn trong y tế tại thừoi điểm hiện tại, nhóm đã phát triển sản phẩm dựa trên những mục tiêu cụ thể như sau:",
                        "Phát triển sản phẩm hỗ trợ người dùng theo dõi và quản lý mọi thông tin sức khoẻ gồm tình trạng sực khoẻ hiện tại, thông tin hồ sơ y tế, lịch sử khám chữa bệnh,... nhằm đem lại thông tin chính xác nhất về tình trạng sức khoẻ của người dùng.",
                        "Cung cấp tính năng hỗ trợ cho người dùng khác không có khả năng sử dụng công nghệ hay kiến thức về y học. Phát triển sản phẩm cho phép người dùng quản lý và theo dõi chi tiết tình trạng sức khoẻ của thành viên khác trong gia đình như bố mẹ ông bà lớn tuổi hay con nhỏ.",
                        "Hỗ trợ kịp thời trong các trường hợp khẩn cấp dựa vào việc cảnh báo đến thành viên trong gia đình, bác sĩ hoặc các địa điểm y tế gần vị trí người dùng đang nguy cấp.",
                        "Nâng cao kiến thức y học của người dùng bằng các thông tin, nghiên cứu từ các tổ chức chính thống. Ngoài ra còn phải hỗ trợ cho phép chia sẻ thông tin, kiến thức giữa cộng đồng người dùng nhưng phải kiểm duyệt chặt chẽ tránh truyền đạt thông tin, kiến thức y tế sai lệch.",
                        "Xây dựng chế độ dành riêng cho y bác sĩ, cung cấp các công cụ hỗ trợ nhằm giúp đỡ cả các y bác sĩ lẫn người bệnh trao đổi thông tin nhanh và tốt nhất.",
                        "",
                        "3. Giới thiệu tổng quan dự án",
                        "Với những mục tiêu đề ra, nhóm đã tiến hành thiết kế và phát triển hệ thống \name gồm 2 sản phẩm dành cho người dùng là 1 ứng dụng người dùng, 1 trang web giới thiệu và 1 sản phẩm dành cho quản lý là trang web quản trị.",
                        "* Ứng dụng người dùng",
                        "Ứng dụng di động đóng vai trò tương tác chính với người dùng, hỗ trợ cho 2 nền tảng di động phổ biến là iOS và Android gồm các chức năng chính sau đây:",
                        "Theo dõi các chỉ số sức khoẻ như nhịp tim, huyết áp,... Theo dõi và thiết lập các hoạt động hằng ngày như chạy bộ, tập luyện, quản lý lượng thức ăn và nước uống. Ngoài ra còn có thể theo dõi chu kỳ kinh nguyệt và chu kỳ rụng chứng cho nhóm người dùng phụ nữ.",
                        "Cung cấp khả năng lưu trữ các hồ sơ y tế, lịch sử và lịch hẹn khám chữa bệnh. Cung cấp các liên hệ y tế, thông tin bác sĩ.",
                        "Hỗ trợ công cụ quản lý tủ thuốc, nhắc uống thuốc, lập kế hoạch và thông báo lịch hẹn.",
                        "Tính năng chẩn đoán tự động dựa trên dữ liệu y tế của hệ thống và thông tin tình trạng người dùng.",
                        "Tính năng cảnh báo khẩn cấp giúp người dùng đang gặp nguy hiểm được hỗ trợ kịp thời.",
                        "Tính năng theo dõi và quản lý sức khoẻ thành viên khác trong gia đình cho phép người dùng theo dõi và hiểu rõ tình trạng sức khoẻ của người thân trong gia đình.",
                        "Đem đến khả năng kết nối cộng đồng và tìm hiểu các thông tin y tế một cách trực quan và chính xác nhất.",
                        "Cung cấp công cụ hỗ trợ kết nối và tương tác giữa các y bác sĩ và bệnh nhân, khách hàng của mình.",
                        "* Trang web giới thiệu",
                        "Trang web giới thiệu cung cấp các thông tin giới thiệu về dự án, về sản phẩm ứng dụng di động, những chính sách quy định và thông tin liên lạc.",
                        "* Trang web quản trị",
                        "Trang web quản trị dành cho quản trị viên của hệ thống, cung cấp những tính năng và công cụ hữu ích sau đây:",
                        "Quản lý và theo dõi mọi thông tin của hệ thống như dữ liệu về người dùng, gia đình, các nhóm cộng đồng,...",
                        "Nhận và xử lý các phản hồi, yêu cầu, báo cáo từ người dùng ứng dụng di động.",
                        "Quản trị nguồn dữ liệu của hệ thống, thêm, xoá, sửa dữ liệu. Gồm các dữ liệu như dữ liệu về thuốc, dữ liệu y tế cho tính năng chẩn đoán tự động, dữ liệu tính calo cho thức ăn, bài tập luyện."
                      ]))))),
      SizedBox(height: 16),
      CustomDivider.common(),
      SizedBox(height: 16)
    ]);
  }

  Widget buildLogout(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SectionComponent(
          title: S.of(context).Logout,
          iconPath: "assets/app_icon/common/out_war0.png",
          isDirection: false,
          colorID: 2,
          onTap: () {
            BlocProvider.of<AppCubit>(context).logout();
            Navigator.pop(context);
          }),
      SizedBox(height: 16),
      GestureDetector(
          onTap: () => removeAccount(context),
          child: Text(S.of(context).Remove_account,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.black54)))
    ]);
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? language = prefs.getString("language");
    return language ?? "vi";
  }

  void removeAccount(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => WarningPopup(
            title: S.of(context).Remove_account,
            cancel: () => Navigator.pop(context),
            delete: () {
              BlocProvider.of<AppCubit>(context).removeAccount();
              Navigator.pop(context);
            }));
  }
}
