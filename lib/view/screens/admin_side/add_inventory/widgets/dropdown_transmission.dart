import 'package:flutter/material.dart';
import 'package:godrive/core/car_details.dart';
import 'package:godrive/core/colors.dart';

class DropdownTransmission extends StatelessWidget {
  const DropdownTransmission({
    super.key,
    required this.selectedtransmission,
    required this.size,
  });

  final ValueNotifier<String?> selectedtransmission;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedtransmission,
      builder: (context, value, child) {
        return Container(
          width: size.width * .7,
          height: 50,
          color: Colors.grey.shade300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              icon: Icon(Icons.arrow_drop_down_circle_outlined,
                  color: Colors.grey.shade300),
              style: const TextStyle(fontWeight: FontWeight.bold, color: black),
              menuMaxHeight: 300,
              hint: const Text('Select Transmission Type'),
              value: value,
              onChanged: (String? newValue) {
                selectedtransmission.value = newValue;
              },
              items:
                  transmissionType.map<DropdownMenuItem<String>>((String company) {
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

