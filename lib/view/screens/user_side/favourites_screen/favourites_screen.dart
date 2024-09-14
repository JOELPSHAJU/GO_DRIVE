import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/view/bloc/search_inventory/search_inventory_bloc.dart';
import 'package:godrive/view/screens/admin_side/view_inventory/widgets/image_viewer.dart';
import 'package:godrive/view/screens/universal_widgets/row.dart';
import 'package:godrive/view/screens/user_side/profile_screen/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String userEmail = currentUser!.email.toString();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: BlocConsumer<InventoryBloc, SearchInventoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is InventoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InventoryLoaded) {
            final favouriteCars = state.inventoryList
                .where((car) =>
                    car['favourites'] != null &&
                    car['favourites'].contains(userEmail))
                .toList();

            if (favouriteCars.isEmpty) {
              return const Center(child: Text('No favourites found'));
            }

            return ListView.builder(
                itemCount: favouriteCars.length,
                itemBuilder: (context, index) {
                  final carData = favouriteCars[index];
                  List favourites = carData['favourites'] ?? [];

                  bool isFavourite = favourites.contains(userEmail);

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        height: 260,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              right: 20,
                              top: 45,
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color.fromARGB(
                                              255, 225, 224, 224),
                                          blurRadius: 10,
                                          spreadRadius: 10)
                                    ],
                                    borderRadius: BorderRadius.circular(100),
                                    color: white),
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<InventoryBloc>(context).add(
                                      RemoveFromFavourites(
                                          carData['id'], userEmail),
                                    );
                                    context
                                        .read<InventoryBloc>()
                                        .add(FetchInventoryEvent());
                                  },
                                  icon: Icon(
                                    isFavourite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavourite ? Colors.red : Colors.grey,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                            _buildCompanyName(carData),
                            _buildPricePerDay(carData),
                            _buildModelName(context, carData),
                            _buildMainImage(carData),
                            _buildSpecificationsRow(context, carData),
                          ],
                        )),
                  );
                });
          } else if (state is InventoryError) {
            return Center(child: Text('Error: '));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}

Positioned _buildCompanyName(dynamic item) {
  return Positioned(
    top: 20,
    left: 20,
    child: Text(
      textAlign: TextAlign.center,
      item['companyName'].toString().toUpperCase(),
      style: GoogleFonts.robotoFlex(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Positioned _buildPricePerDay(dynamic item) {
  return Positioned(
    top: 10,
    right: 20,
    child: Text(
      textAlign: TextAlign.center,
      '₹ ${item['pricePerDay'].toString().toUpperCase()}/day',
      style: GoogleFonts.robotoFlex(
        color: const Color.fromARGB(255, 54, 155, 58),
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Positioned _buildModelName(BuildContext context, dynamic item) {
  return Positioned(
    top: 35,
    left: 20,
    child: BorderedText(
      strokeWidth: 2,
      strokeColor: const Color.fromARGB(154, 0, 0, 0),
      child: Text(
        textAlign: TextAlign.center,
        item['modelName'].toString().toUpperCase(),
        style: GoogleFonts.robotoFlex(
          color: Colors.transparent,
          fontSize: MediaQuery.of(context).size.width * .08,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Positioned _buildMainImage(dynamic item) {
  return Positioned(
    bottom: 65,
    left: 2,
    right: 2,
    child: CachedNetworkImage(imageUrl: item['mainImage']),
  );
}

Positioned _buildSpecificationsRow(
  BuildContext context,
  dynamic item,
) {
  return Positioned(
    bottom: 20,
    right: 2,
    left: 2,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildSpecificationItem(context, item, 'maxPower', engine, 'hp'),
        _buildSpecificationItem(
            context, item, 'seatingCapacity', seat, 'Person'),
        _buildSpecificationItem(context, item, 'fuelType', fuel, ''),
      ],
    ),
  );
}

Widget _buildSpecificationItem(BuildContext context, dynamic item, String key,
    String image, String suffix) {
  return Container(
    height: 40,
    width: 110,
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
    ),
    child: Center(
      child: RowSearch(image: image, last: suffix, Texts: item[key]),
    ),
  );
}
