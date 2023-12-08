import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ScreenFullScreenImage extends StatelessWidget {
  const ScreenFullScreenImage({Key? key, required this.imageUrl})
      : super(key: key);

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'full_screen_image',
          child: PhotoViewGallery(
            pageController: PageController(),
            scrollPhysics: const BouncingScrollPhysics(),
            pageOptions: [
              PhotoViewGalleryPageOptions(
                imageProvider: imageUrl == ''
                    ? const AssetImage('path_to_placeholder_image')
                    : NetworkImage(imageUrl!) as ImageProvider,
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
            ],
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
            // Add more customization options as needed
          ),
        ),
      ),
    );
  }
}
