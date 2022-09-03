import 'package:anthealth_mobile/models/post/post_models.dart';
import 'package:anthealth_mobile/views/post/post_page.dart';
import 'package:anthealth_mobile/views/theme/colors.dart';
import 'package:flutter/material.dart';

class PostComponent extends StatelessWidget {
  const PostComponent({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => PostPage(post: post))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black12,
              child: Image.network(
                  (post.coverImage != "")
                      ? post.coverImage
                      : "https://vnpi-hcm.vn/wp-content/uploads/2018/01/no-image-800x600.png",
                  height: 120,
                  fit: BoxFit.fitWidth),
            ),
            Container(
              color: AnthealthColors.black4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(post.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
