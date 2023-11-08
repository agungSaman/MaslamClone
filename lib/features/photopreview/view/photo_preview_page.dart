import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'photo_preview_controller.dart';

class PhotoPreviewPage extends GetView<PhotoPreviewController> {
  static const routeName = '/photo-preview';

  const PhotoPreviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: InteractiveViewer(
                child: Image.network(controller.param.imageUrl ?? '',
                    frameBuilder: (BuildContext context, Widget child,
                        int? frame, bool wasSynchronouslyLoaded) {
                      return Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: child,
                      );
                    },
                    fit: BoxFit.contain,
                    loadingBuilder: (context, widget, progress) =>
                        progress == null ? widget : const SizedBox(),
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
                    })),
          ),
          Positioned(
              top: 36,
              left: 18,
              child: IconButton(
                onPressed: controller.onTapCloseButton,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                ),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: controller.param.description != null
                ? Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black, Colors.transparent])),
                    child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          controller.param.description!,
                          style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.white),
                        )),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
