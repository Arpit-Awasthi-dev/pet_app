import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullScreenImagePage extends StatelessWidget {
  static const String routeName = '/full_screen_image_page';
  final String image;

  const FullScreenImagePage({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const Key('key'),
      movementDuration: const Duration(milliseconds: 120),
      dismissThresholds: const {
        DismissDirection.up: 0.05,
        DismissDirection.down: 0.05,
        DismissDirection.vertical: 0.05
      },
      direction: DismissDirection.vertical,
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (_, index) => _item(),
                itemCount: 1,
              ),
              Positioned(
                top: 60,
                right: 8,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _item() {
    return PhotoViewGalleryPageOptions.customChild(
      child: Image.asset(image),
    );
  }
}
