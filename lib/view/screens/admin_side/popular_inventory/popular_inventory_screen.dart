import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/view/bloc/delete_popular_inventories/delete_popular_inventory_bloc.dart';
import 'package:godrive/view/bloc/get_popular_inventories/get_popular_invetories_bloc.dart';
import 'package:godrive/view/screens/universal_widgets/row.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularInventoryScreen extends StatefulWidget {
  const PopularInventoryScreen({super.key});

  @override
  State<PopularInventoryScreen> createState() => _PopularInventoryScreenState();
}

class _PopularInventoryScreenState extends State<PopularInventoryScreen> {
  @override
  void initState() {
    context
        .read<GetPopularInvetoriesBloc>()
        .add(GetPopularInvetoriesEventInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: black,
          surfaceTintColor: black,
          iconTheme: const IconThemeData(color: white),
          title: const Text(
            'POPULAR INVENTORIES',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: white),
          ),
        ),
        body: BlocBuilder<GetPopularInvetoriesBloc, GetPopularInvetoriesState>(
          builder: (context, state) {
            if (state is GetPopularInvetoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetPopularInvetoriesSucess) {
              if (state.carDetails.isEmpty) {
                return const Center(child: Text('No Data Found'));
              }
              return ListView.builder(
                itemCount: state.carDetails.length,
                itemBuilder: (context, index) {
                  final car = state.carDetails[index];
                  return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: const LinearBorder(),
                              backgroundColor: white,
                              title: const Text(
                                'Confirm delete?',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              content: const Text(
                                'Are you sure you want to delete this Inventory from Popular Inventories?',
                              ),
                              actions: <Widget>[
                                MaterialButton(
                                  color:
                                      const Color.fromARGB(255, 206, 206, 206),
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                MaterialButton(
                                  color: red,
                                  child: const Text('Delete',
                                      style: TextStyle(color: white)),
                                  onPressed: () {
                                    if (kDebugMode) {
                                      print(car['documentId']);
                                    }
                                    context
                                        .read<DeletePopularInventoryBloc>()
                                        .add(GetPopularInvetoriesDeleteEvent(
                                            docid: car['documentId']));

                                    context
                                        .read<GetPopularInvetoriesBloc>()
                                        .add(
                                            GetPopularInvetoriesEventInitial());
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
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
                                    color:
                                        const Color.fromARGB(255, 54, 155, 58),
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
                                          MediaQuery.of(context).size.width *
                                              .08,
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
                                                  Texts: car['maxPower']))),
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
            } else if (state is GetPopularInvetoriesError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return Container();
          },
        ));
  }
}
