import 'package:flutter/material.dart';

class ShowSnackBar {
  static showErrorSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        padding: const EdgeInsets.all(16),
        elevation: 0,
        backgroundColor: Color(0xFFFBEAE9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        content: CustomSnackBar(isSuccess: false, content: content),
      ),
    );
  }

  static showSuccessSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        padding: const EdgeInsets.all(16),
        elevation: 0,
        backgroundColor: Color(0xFFE9FCEC),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        content: CustomSnackBar(isSuccess: true, content: content),
      ),
    );
  }

  static showStatusSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        padding: const EdgeInsets.all(16),
        elevation: 0,
        backgroundColor: Color(0xFFA3A3A3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        content: CustomStatusSnackBar(content: content),
      ),
    );
  }
}

class CustomSnackBar extends StatelessWidget {
  const CustomSnackBar(
      {Key? key, required this.isSuccess, required this.content})
      : super(key: key);

  final bool isSuccess;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            // the red cross is bigger than the green check
            width: isSuccess ? 24 : 20,
            height: isSuccess ? 24 : 20,
            child: Image.asset(isSuccess
                ? "assets/app_icon/common/icon-green-check.png"
                : "assets/app_icon/common/icon-red-cross.png"),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              content,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: isSuccess ? Color(0xFF00C11F) : Color(0xFFD43513)),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: isSuccess ? Color(0xFFE9FCEC) : Color(0xFFFBEAE9),
        shape: BoxShape.rectangle,
      ),
    );
  }
}

class CustomStatusSnackBar extends StatelessWidget {
  const CustomStatusSnackBar({Key? key, required this.content})
      : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              content,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFA3A3A3),
        shape: BoxShape.rectangle,
      ),
    );
  }
}
