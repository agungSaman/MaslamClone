import 'dart:io';

import 'package:flutter/material.dart';

import '../features/shared/attachment/attachment_type.dart';
import 'loading_image.dart';

class AttachmentImage extends StatelessWidget {
  final AttachmentUrlType type;
  final String imageUrl;

  const AttachmentImage({Key? key, required this.type, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return type == AttachmentUrlType.url
        ? Image.network(imageUrl,
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              return Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: child,
              );
            },
            fit: BoxFit.cover,
            loadingBuilder: (context, widget, progress) => progress == null
                ? widget
                : LoadingImage(
                    progress: progress.expectedTotalBytes != null
                        ? progress.cumulativeBytesLoaded /
                            progress.expectedTotalBytes!
                        : null,
                  ),
            errorBuilder: (context, widget, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(228, 228, 228, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Padding(
                    padding: EdgeInsets.all(18),
                    child: Icon(
                      Icons.broken_image,
                      size: 24,
                      color: Color.fromRGBO(178, 178, 178, 1.0),
                    )),
              );
            })
        : Image.file(
            File(
              imageUrl,
            ),
            frameBuilder: (BuildContext context, Widget child, int? frame,
                bool wasSynchronouslyLoaded) {
              return Container(
                width: 90,
                height: 90,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: child,
              );
            },
            fit: BoxFit.cover,
            errorBuilder: (context, widget, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(228, 228, 228, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: const Padding(
                    padding: EdgeInsets.all(18),
                    child: Icon(
                      Icons.broken_image,
                      size: 24,
                      color: Color.fromRGBO(178, 178, 178, 1.0),
                    )),
              );
            });
  }
}
