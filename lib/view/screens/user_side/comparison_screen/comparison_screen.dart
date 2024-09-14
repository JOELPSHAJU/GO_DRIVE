import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata__state.dart';
import 'package:godrive/view/screens/universal_widgets/appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata_bloc.dart';


class ComparisonScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  const ComparisonScreen({super.key, required this.data});

  @override
  _ComparisonScreenState createState() => _ComparisonScreenState();
}

class _ComparisonScreenState extends State<ComparisonScreen> {
  Map<String, dynamic>? selectedInventory; // To store selected inventory details

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppbarWidget(title: 'COMPARE INVENTORIES'),
      body: Column(
        children: [
          h10,
          MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            height: 40,
            color: Colors.white,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'SELECT INVENTORY',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            onPressed: () => _showInventoryBottomSheet(context),
          ),
          _buildComparisonDetail('ENGINE', widget.data['engineDisplacement'],
              selectedInventory?['engineDisplacement'] ?? 'Select Inventory'),
          // Add more comparison fields here as needed, similar to the one above
        ],
      ),
    );
  }

  void _showInventoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocBuilder<CarDetailsBloc, CarDetailsState>(
          builder: (context, state) {
            if (state is CarDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CarDetailsLoaded) {
              List<Map<String, dynamic>> carDetails = state.carDetails
                  .where((car) =>
                      car['documentId'] != widget.data['documentId']) // Exclude current inventory
                  .toList();

              return ListView.builder(
                itemCount: carDetails.length,
                itemBuilder: (context, index) {
                  final car = carDetails[index];
                  return ListTile(
                    title: Text('${car['company']} ${car['modelName']}'),
                    subtitle: Text('Engine: ${car['engineDisplacement']}'),
                    onTap: () {
                      setState(() {
                        selectedInventory = car; // Update selected inventory
                      });
                      Navigator.pop(context); // Close bottom sheet
                    },
                  );
                },
              );
            } else if (state is CarDetailsError) {
              return Center(child: Text('Error: ${state.error}'));
            }
            return const SizedBox();
          },
        );
      },
    );
  }

  Widget _buildComparisonDetail(
      String title, String value1, String value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value1,
            style:
                GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            title,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value2,
            style:
                GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
