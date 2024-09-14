import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class Whychooseus extends StatelessWidget {
  const Whychooseus({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Why We Are Different',
              style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Unlock The Road To Adventure With Our Diverse Fleet Of Our Luxury Rental Cars.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14, color: darkgrey, fontWeight: FontWeight.w500),
            ),
          ),

          // ignore: sized_box_for_whitespace
          Container(
            width: MediaQuery.of(context).size.width,
            height: 230,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                whychoose(
                    image: whyChooseUs2,
                    subtitle:
                        'Go Drive provides top-class services at an affordable price.',
                    title: 'Low Prices'),
                whychoose(
                  image: whyChooseUs3,
                  title: 'Experienced Staff',
                  subtitle:
                      'We Hire best experts in everything concerning car rental.',
                ),
                whychoose(
                    image: whyChooseUs4,
                    subtitle:
                        'Our team guarantee reliable support in addition to the offered services.',
                    title: 'Reliable support'),
                whychoose(
                    image: whyChooseUs1,
                    subtitle:
                        'You can find our car rental officess throughout kerala',
                    title: 'Convienient Location')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class whychoose extends StatelessWidget {
  const whychoose({
    required this.image,
    required this.subtitle,
    required this.title,
    super.key,
  });
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * .4,
        height: 280,
        decoration: BoxDecoration(color: Colors.grey.shade300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            h10,
            SizedBox(
              height: 70,
              width: 70,
              child: Image.asset(
                image,
                color: const Color.fromARGB(255, 1, 1, 1),
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 0, 0, 0)),
            ),
            h10,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  textAlign: TextAlign.center,
                  subtitle,
                  style: GoogleFonts.poppins(
                      fontSize: 13, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
