import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/widgets/image_viewer.dart';
import 'package:godrive/view/screens/user_side/booking_screen/booking_screen.dart';
import 'package:godrive/view/screens/user_side/booking_screen/widgets/details_viewer.dart';
import 'package:godrive/view/screens/user_side/view_details_screen/widgets/custom_navbar.dart';
import 'package:godrive/view/screens/user_side/view_details_screen/widgets/image_data.dart';
import 'package:godrive/view/screens/user_side/view_details_screen/widgets/main_data.dart';
import 'package:godrive/view/screens/user_side/view_details_screen/widgets/row_details.dart';
import 'package:google_fonts/google_fonts.dart';

class ParticularInventory extends StatelessWidget {
  final Map<String, dynamic> data;
  final int index;

  const ParticularInventory({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              ImageData(index: index,),
              const TabBar(
                indicatorColor: Color.fromARGB(255, 19, 59, 89),
                labelColor: Color.fromARGB(255, 19, 59, 89),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Overview"),
                  Tab(text: "Specification"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 16.0, right: 16, left: 16),
                      child: ListView(
                        children: [
                          main_data(data: data),
                          const SizedBox(height: 16),
                          Text(
                            data['overview'] ?? 'No overview available.',
                            style: GoogleFonts.gowunBatang(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          h10,
                          SizedBox(
                            width: size.width,
                            child: details_row(data: data),
                          ),
                          h10,
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      companybanner,
                                    ),
                                    fit: BoxFit.cover)),
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                          ),
                          h10
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Technical Specification',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                            h10,
                            buildDetailsTable(data)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          data: data,
          context: context,
        ),
      ),
    );
  }
}
