import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:anthealth_mobile/models/health/indicator_models.dart';
import 'package:anthealth_mobile/views/post/single_post.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class IndicatorMoreInfo extends StatelessWidget {
  const IndicatorMoreInfo({Key? key, required this.information})
      : super(key: key);

  final MoreInfo information;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 32),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('* ',
              style: Theme.of(context).textTheme.overline!.copyWith(
                  color: AnthealthColors.black1, fontFamily: 'RobotoRegular')),
          Expanded(
              child: RichText(
                  text: TextSpan(
                      text: information.getContent(),
                      style: Theme.of(context).textTheme.overline!.copyWith(
                          color: AnthealthColors.black1,
                          fontFamily: 'RobotoRegular',
                          letterSpacing: 0.2),
                      children: [
                if (information.getUrl() != "")
                  TextSpan(
                      text: ' ' + S.of(context).Learn_more,
                      style: TextStyle(
                          color: AnthealthColors.primary1,
                          fontFamily: 'RobotoMedium'),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          //launchUrlString(information.getUrl());
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SinglePost(
                                          highlight: "Flutter",
                                          title:
                                              "Flutter là gì? Các đặc tính vượt trội của Flutter",
                                          content: [
                                            "Flutter là gì?",
                                            "Bạn có thể hiểu Flutter là bộ công cụ giao diện người dùng của Google để tạo các ứng dụng đẹp, được biên dịch native cho thiết bị di động, web và máy tính để bàn từ một mã nguồn duy nhất.",
                                            "Flutter là một framework giao diện người dùng mã nguồn mở miễn phí được tạo bởi Google và được phát hành vào tháng 5 năm 2017.",
                                            "Nói một cách dễ hiểu, điều này cho phép bạn tạo một ứng dụng di động chỉ với một lần code. Có nghĩa là bạn có thể sử dụng một ngôn ngữ lập trình và một mã nguồn để tạo hai ứng dụng khác nhau (IOS và Android).",
                                            "Không giống như các giải pháp phổ biến khác, Flutter không phải là một framework hoặc thư viện mà đó là một SDK hoàn chỉnh – bộ công cụ phát triển phần mềm đa nền tảng.",
                                            "https://200lab-blog.imgix.net/2021/07/0_OA8mG-mK8hncsgQ4.jpg?auto=format,compress&w=1500",
                                            "Để phát triển với Flutter, bạn sẽ sử dụng một ngôn ngữ lập trình có tên là Dart. Đây cũng là ngôn ngữ của Google được tạo vào tháng 10 năm 2011 và đã được cải thiện rất nhiều trong những năm qua. Dart tập trung vào phát triển front-end, bạn có thể sử dụng nó để tạo các ứng dụng di động và web.",
                                            "Quá trình phát triển Flutter",
                                            "https://d50cmv7hkyx4e.cloudfront.net/wp-content/uploads/2021/06/23141932/facebook_cover-1024x538-1.png",
                                            "Vào năm 2015, Google đã công bố Flutter, một SDK mới dựa trên ngôn ngữ Dart, làm nền tảng tiếp theo để phát triển Android và vào năm 2017, phiên bản alpha của nó (0.0.6) đã được phát hành cho công chúng lần đầu tiên.",
                                            "Vào ngày 4 tháng 12 năm 2018, Flutter 1.0 đã được phát hành tại sự kiện Flutter Live và có sẵn để các nhà phát triển có thể bắt đầu sử dụng SDK để tạo ứng dụng dễ dàng hơn. Đây được đánh dấu là phiên bản “stable” đầu tiên."
                                          ])));
                        })
              ])))
        ]));
  }
}
