import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/bloc/add_to_popular/add_to_popular_bloc.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/widgets/debouncer.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/widgets/detail_row.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/widgets/image_viewer.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/widgets/spec_row.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class DetailsScreenAdmin extends StatelessWidget {
  final Map<String, dynamic> car;

  DetailsScreenAdmin({
    super.key,
    required this.car,
  });
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        backgroundColor: white,
        body: BlocListener<AddToPopularBloc, AddToPopularState>(
          listener: (context, state) {
            if (state is AddToPopularloadingState) {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF2193b0),
                          Color(0xFF6dd5ed),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  backgroundColor: Colors
                      .transparent, 
                  elevation: 0,
                ),
              );
            }
            if (state is AddToPopularSucessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to Popular successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is AddToPopularErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Failed to add to Popular.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            children: [
              ImageViewer(images: car['additionalImages']),
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
                    SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        car['companyName'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: grey,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        car['modelName'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "₹${car['pricePerDay']}/day",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                        color: green50),
                                  ),
                                ],
                              ),
                              Text(
                                car['overview'],
                                style: GoogleFonts.gowunBatang(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              h20,
                              OverviewRow(car: car),
                            ],
                          )),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              h10,
                              const Text(
                                'Technical Specification',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    color: black,
                                    fontSize: 18),
                              ),
                              h10,
                              SpecificationRow(
                                label: 'Category : ',
                                value: car['category'],
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Engine Displacement : ',
                                value: '${car['engineDisplacement']} CC',
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Maximum Power : ',
                                value: '${car['maxPower']} hp',
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Maximum Torque : ',
                                value: '${car['maxTorque']} nm',
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Zero to Hundred : ',
                                value: '${car['zeroToHundred']} seconds',
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Seating Capacity : ',
                                value: '${car['seatingCapacity']} persons',
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Fuel Type : ',
                                value: car['fuelType'],
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Fuel Tank Capacity : ',
                                value: '${car['fuelTankCapacity']} ltrs',
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Ground Clearence : ',
                                value: '${car['groundClearance']} mm',
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Gearbox : ',
                                value: '${car['gearbox']} speed',
                              ),
                              const Divider(),
                              SpecificationRow(
                                label: 'Transmission Type : ',
                                value: car['transmissionType'],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: MediaQuery.of(context).size.height * .08,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: black)),
                        color: Color.fromARGB(255, 255, 255, 255)),
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width * .5,
                    child: const Center(
                        child: Text(
                      'Go back',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, color: black),
                    ))),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .08,
                width: MediaQuery.of(context).size.width * .5,
                color: black,
                child: Center(
                    child: TextButton(
                        onPressed: () {
                          _debouncer.run(() {
                            final Map<String, dynamic> data = {
                              'companyName': car['companyName'],
                              'modelName': car['modelName'],
                              'maxPower': car['maxPower'],
                              'seatingCapacity': car['seatingCapacity'],
                              'fuelType': car['fuelType'],
                              'mainImage': car['mainImage'],
                              'pricePerDay': car['pricePerDay'],
                            };
                            context
                                .read<AddToPopularBloc>()
                                .add(AddToPopularButtonClickEvent(data: data));
                          });
                        },
                        child: const Text(
                          'Add to Popular',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: white),
                        ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
