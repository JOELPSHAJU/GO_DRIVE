import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/bloc/add_advertisement/add_advertisement_bloc.dart';
import 'package:godrive/view/screens/user_side/home_screen/widgets/how_it_works.dart';
import 'package:godrive/view/screens/user_side/home_screen/widgets/why_choose_us.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Advertisement(
                size: size,
              ),
              h20,
              const Whychooseus(),
              const HowitWorks(),
              h30
            ],
          ),
        ),
      ),
    );
  }
}

class Advertisement extends StatefulWidget {
  const Advertisement({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<Advertisement> createState() => _AdvertisementState();
}

class _AdvertisementState extends State<Advertisement> {
  @override
  void initState() {
    context.read<AdvertisementBloc>().add(FetchAdvertisementsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvertisementBloc, AdvertisementState>(
      builder: (context, state) {
        if (state is AdvertisementFetchSuccess) {
          return CarouselSlider.builder(
            itemCount: state.imagePaths.length,
            itemBuilder: (context, index, realIndex) {
              return SizedBox(
                width: widget.size.width,
                height: widget.size.height * .3,
                child: CachedNetworkImage(
                  imageUrl: state.imagePaths[index],
                  fit: BoxFit.cover,
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              autoPlay: true,
              reverse: true,
              autoPlayInterval: const Duration(seconds: 7),
            ),
          );
        }
        return Container(
          width: widget.size.width,
          height: widget.size.height * .3,
          color: white,
        );
      },
    );
  }
}
