import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata_bloc.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata_event.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata__state.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/details_screen.dart';
import 'package:godrive/view/screens/universal_widgets/row.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewInventory extends StatefulWidget {
  const ViewInventory({super.key});

  @override
  State<ViewInventory> createState() => _ViewInventoryState();
}

class _ViewInventoryState extends State<ViewInventory> {
  @override
  void initState() {
    context.read<CarDetailsBloc>().add(FetchCarDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        backgroundColor: black,
        surfaceTintColor: black,
        centerTitle: true,
        title: const Text(
          'OUR FLEET',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: white),
        ),
      ),
      body: BlocBuilder<CarDetailsBloc, CarDetailsState>(
        builder: (context, state) {
          if (state is CarDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CarDetailsLoaded) {
            if (state.carDetails.isEmpty) {
              return const Center(child: Text('No Data Found'));
            }
            return ListView.builder(
              itemCount: state.carDetails.length,
              itemBuilder: (context, index) {
                final car = state.carDetails[index];
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (c) => DetailsScreenAdmin(
                                    car: state.carDetails[index],
                                  )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 260,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Text(
                                textAlign: TextAlign.center,
                                car['companyName'].toString().toUpperCase(),
                                style: GoogleFonts.robotoFlex(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: Text(
                                textAlign: TextAlign.center,
                                '₹ ${car['pricePerDay'].toString().toUpperCase()}/day',
                                style: GoogleFonts.robotoFlex(
                                  color: const Color.fromARGB(255, 54, 155, 58),
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 35,
                              left: 20,
                              child: BorderedText(
                                strokeWidth: 2,
                                strokeColor: const Color.fromARGB(154, 0, 0, 0),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  car['modelName'].toString().toUpperCase(),
                                  style: GoogleFonts.robotoFlex(
                                    color: Colors.transparent,
                                    fontSize:
                                        MediaQuery.of(context).size.width * .08,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 65,
                                left: 2,
                                right: 2,
                                child: CachedNetworkImage(
                                    imageUrl: car['mainImage'])),
                            Positioned(
                              bottom: 20,
                              right: 2,
                              left: 2,
                              child: SizedBox(
                                width: size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        height: 40,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        child: Center(
                                            child: RowSearch(
                                                image: engine,
                                                last: 'hp',
                                                Texts: car[
                                                    'engineDisplacement']))),
                                    Container(
                                        height: 40,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        child: Center(
                                            child: RowSearch(
                                                image: seat,
                                                last: 'Person',
                                                Texts:
                                                    car['seatingCapacity']))),
                                    Container(
                                        height: 40,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        child: Center(
                                            child: RowSearch(
                                                image: fuel,
                                                last: '',
                                                Texts: car['fuelType']))),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              },
            );
          } else if (state is CarDetailsError) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return Container();
        },
      ),
    );
  }
}
