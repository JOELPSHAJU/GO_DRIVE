import 'package:bordered_text/bordered_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/view/screens/universal_widgets/row.dart';
import 'package:godrive/view/screens/user_side/view_details_screen/view_details_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:godrive/view/bloc/search_inventory/search_inventory_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeSearch();
  }

  void _initializeSearch() {
    context.read<InventoryBloc>().add(FetchInventoryEvent());

    _searchController.addListener(() {
      context
          .read<InventoryBloc>()
          .add(SearchInventory(_searchController.text));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      extendBody: true,
      appBar: _buildAppBar(),
      body: BlocBuilder<InventoryBloc, SearchInventoryState>(
        builder: (context, inventoryState) {
          if (inventoryState is InventoryLoading) {
            return _buildLoadingIndicator();
          } else if (inventoryState is InventoryLoaded) {
            return _buildSearchResults(inventoryState.inventoryList);
          } else {
            return _buildErrorState();
          }
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      surfaceTintColor: Colors.white,
      toolbarHeight: 70,
      backgroundColor: Colors.white,
      title: _buildSearchField(),
    );
  }

  Widget _buildSearchField() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextFormField(
        controller: _searchController,
        cursorColor: Colors.black,
        cursorWidth: 1,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          hintText: 'Search your inventory',
          prefixIcon: const Icon(Icons.search),
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            color: Colors.grey,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          border: InputBorder.none,
          enabledBorder: _buildOutlineInputBorder(Colors.grey),
          focusedBorder: _buildOutlineInputBorder(Colors.black),
        ),
      ),
    );
  }

  OutlineInputBorder _buildOutlineInputBorder(Color borderColor) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildSearchResults(List<dynamic> searchResults) {
    if (searchResults.isEmpty) {
      return _buildNoResultsFound();
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final item = searchResults[index];
          return _buildSearchResultItem(context, item,index);
        },
      );
    }
  }

  Widget _buildNoResultsFound() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Oops, No Inventory Found!',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * .04,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 81, 81, 81),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultItem(BuildContext context, dynamic item,int index) {
    return InkWell(
      onTap: () => _navigateToDetailsScreen(context, item,index),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          height: 260,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: _buildItemContent(context, item),
        ),
      ),
    );
  }

  void _navigateToDetailsScreen(BuildContext context, dynamic item,int index) {
    Map<String, dynamic> carData = {
      'additionalImages': item['additionalImages'],
      'category': item['category'],
      'id': item['id'],
      'companyName': item['companyName'],
      'engineDisplacement': item['engineDisplacement'],
      'fuelType': item['fuelType'],
      'fuelTankCapacity': item['fuelTankCapacity'],
      'gearbox': item['gearbox'],
      'groundClearance': item['groundClearance'],
      'mainImage': item['mainImage'],
      'maxPower': item['maxPower'],
      'maxTorque': item['maxTorque'],
      'modelName': item['modelName'],
      'numberPlate': item['numberPlate'],
      'overview': item['overview'],
      'seatingCapacity': item['seatingCapacity'],
      'transmissionType': item['transmissionType'],
      'zeroToHundred': item['zeroToHundred'],
      'pricePerDay': item['pricePerDay'],
    };
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (_) => ParticularInventory(data: carData,index:index,)),
    );
  }

  Widget _buildItemContent(BuildContext context, dynamic item) {
    return Stack(
      children: [
        _buildCompanyName(item),
        _buildPricePerDay(item),
        _buildModelName(context, item),
        _buildMainImage(item),
        _buildSpecificationsRow(context, item),
      ],
    );
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
      top: 20,
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

  Widget _buildErrorState() {
    return const Center(child: Text('Error fetching inventory'));
  }
}
