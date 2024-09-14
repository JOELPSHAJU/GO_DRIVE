import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';

class ViewOntapImages extends StatelessWidget {
  final List<String> images;
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  ViewOntapImages({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .38,
      child: Column(
        children: [
          ValueListenableBuilder<int>(
            valueListenable: currentIndexNotifier,
            builder: (context, currentIndex, _) {
              return GestureDetector(
                onTap: () {},
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
                      color: black,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(
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
                      width: MediaQuery.of(context).size.width * .23,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndexNotifier.value == index
                              ? black
                              : grey,
                          width: 2,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: images[index].toString(),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.grey,
                          size: 30,
                        ),
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: black,
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
