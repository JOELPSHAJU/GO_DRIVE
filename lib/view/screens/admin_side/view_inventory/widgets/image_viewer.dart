import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';

class ImageViewer extends StatelessWidget {
  final List<dynamic> images;
  ImageViewer({
    super.key,
    required this.images,
  });
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .38,
      child: Column(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: currentIndexNotifier,
            builder: (context, currentIndex, child) {
              return Container(
                decoration: const BoxDecoration(),
                height: MediaQuery.of(context).size.height * .29,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CachedNetworkImage(
                        imageUrl: images[currentIndex],
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.grey,
                          size: 30,
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .09,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      currentIndexNotifier.value = index;
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * .0,
                      width: MediaQuery.of(context).size.width * .23,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndexNotifier.value == index
                              ? blue
                              : Colors.black,
                          width: 2,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: images[index],
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.grey,
                          size: 30,
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
