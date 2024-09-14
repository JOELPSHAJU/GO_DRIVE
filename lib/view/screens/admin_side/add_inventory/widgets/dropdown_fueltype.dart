import 'package:flutter/material.dart';
import 'package:godrive/core/car_details.dart';
import 'package:godrive/core/colors.dart';

class DropdownFuelType extends StatelessWidget {
  const DropdownFuelType({
    super.key,
    required this.selectedfueltype,
    required this.size,
  });

  final ValueNotifier<String?> selectedfueltype;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedfueltype,
      builder: (context, value, child) {
        return Container(
          color: const Color.fromRGBO(224, 224, 224, 1),
          width: size.width * .7,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              icon: Icon(
                Icons.arrow_drop_down_circle_outlined,
                color: Colors.grey.shade300,
              ),
              style: const TextStyle(fontWeight: FontWeight.bold, color: black),
              menuMaxHeight: 300,
              hint: const Text('Select Fuel Type'),
              value: value,
              onChanged: (String? newValue) {
                selectedfueltype.value = newValue;
              },
              items: fueltypes.map<DropdownMenuItem<String>>((String company) {
                return DropdownMenuItem<String>(
                  value: company,
                  child: Text(company),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
