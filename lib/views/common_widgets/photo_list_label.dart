import 'package:anthealth_mobile/generated/l10n.dart';
import 'package:flutter/material.dart';

class PhotoListLabel extends StatelessWidget {
  const PhotoListLabel(
      {Key? key,
      required this.photoPath,
      required this.width,
      this.onTap,
      this.isShowNoData})
      : super(key: key);

  final List<String> photoPath;
  final double width;
  final VoidCallback? onTap;
  final bool? isShowNoData;

  @override
  Widget build(BuildContext context) {
    if (photoPath.length == 0 && isShowNoData != false)
      return Text(S.of(context).no_section_data,
          style: Theme.of(context).textTheme.bodyText2);
    final int maxSize = width ~/ 100;
    final bool isOverFlow = photoPath.length > maxSize;
    final List<String> photoShow = [];
    for (int i = 0; i < maxSize - 1 && i < photoPath.length; i++)
      photoShow.add(photoPath[i]);
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: photoShow
                .where((element) => photoShow.indexOf(element) < maxSize)
                .map((url) => Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          GestureDetector(
                              onTap: onTap ?? () => onPhotoTap(context, url),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(url,
                                      height:
                                          (width - 16 * maxSize + 16) / maxSize,
                                      width:
                                          (width - 16 * maxSize + 16) / maxSize,
                                      fit: BoxFit.cover))),
                          SizedBox(width: 16)
                        ])))
                .toList() +
            [
              Container(
                  child: Stack(children: [
                (photoPath.length >= maxSize)
                    ? GestureDetector(
                        onTap: onTap,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(photoPath[maxSize - 1],
                                height: (width - 16 * maxSize + 16) / maxSize,
                                width: (width - 16 * maxSize + 16) / maxSize,
                                fit: BoxFit.cover)))
                    : Container(),
                (isOverFlow)
                    ? GestureDetector(
                        onTap: onTap,
                        child: Container(
                            alignment: Alignment.center,
                            height: (width - 16 * maxSize + 16) / maxSize,
                            width: (width - 16 * maxSize + 16) / maxSize,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(16)),
                            child: Text(
                                "+" + (photoPath.length - maxSize).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        color: Colors.white, fontSize: 42))))
                    : Container()
              ]))
            ]);
  }

  Future<dynamic> onPhotoTap(BuildContext context, String url) {
    return showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        context: context,
        builder: (_) => SafeArea(
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: InteractiveViewer(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(url, fit: BoxFit.contain),
                    )))));
  }
}
