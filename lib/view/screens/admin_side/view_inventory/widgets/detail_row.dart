import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';

class OverviewRow extends StatelessWidget {
  const OverviewRow({
    super.key,
    required this.car,
  });

  final Map<String, dynamic> car;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 80,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: grey)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                engine,
                width: 35,
              ),
              Text(
                "${car['engineDisplacement']} hp",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          height: 80,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: grey)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                seat,
                width: 35,
              ),
              Text(
                "${car['seatingCapacity']} person",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Container(
          height: 80,
          width: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: grey)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                engine,
                width: 35,
              ),
              Text(
                "${car['fuelType']} ",
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}

