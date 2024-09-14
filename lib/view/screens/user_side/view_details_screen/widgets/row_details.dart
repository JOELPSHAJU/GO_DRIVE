import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';

class details_row extends StatelessWidget {
  const details_row({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 110,
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(
                  color: lightgrey, width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                engine,
                width: 40,
                color: darkgrey,
              ),
              Text(
                '${data['maxPower']} hp',
                style: const TextStyle(
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Container(
          width: 110,
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(
                  color: lightgrey, width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                turbo,
                width: 40,
                color: darkgrey,
              ),
              Text(
                '${data['maxTorque']} nm',
                style: const TextStyle(
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Container(
          width: 110,
          height: 80,
          decoration: BoxDecoration(
              border: Border.all(
                  color: lightgrey, width: 2),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                fuel,
                width: 40,
                color: darkgrey,
              ),
              Text(
                '${data['fuelType']} ',
                style: const TextStyle(
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        )
      ],
    );
  }
}

