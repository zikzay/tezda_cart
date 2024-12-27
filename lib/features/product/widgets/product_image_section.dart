import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageSection extends StatefulWidget {
  final List<String> images;

  const ImageSection({required this.images, Key? key}) : super(key: key);

  @override
  _ImageSectionState createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  int _currentImageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentImageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 300,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.images[index],
                  placeholder: (context, url) => Image.asset('assets/images/default-product.jpg'),
                  errorWidget: (context, url, error) => Image.asset('assets/images/default-product.jpg'),
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          if (widget.images.length > 1)
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentImageIndex = index;
                        _pageController.jumpToPage(index);
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: _currentImageIndex == index ? const Color.fromARGB(255, 193, 145, 0) : Colors.black12,
                          width: 2,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: widget.images[index],
                        placeholder: (context, url) => Image.asset('assets/images/default-product.jpg'),
                        errorWidget: (context, url, error) => Image.asset('assets/images/default-product.jpg'),
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
