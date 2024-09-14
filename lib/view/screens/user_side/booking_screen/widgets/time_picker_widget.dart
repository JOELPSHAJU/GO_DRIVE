import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';


class TimepickerWidget extends StatelessWidget {
  const TimepickerWidget({
    super.key,
    required this.size,
    required this.onTap,
    required this.title,
    required this.time,
  });
  final String title;
  final VoidCallback onTap;
  final Size size;
  final String time;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 8),
          width: size.width,
          height: 55,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade600),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 17),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 35,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 219, 215, 215),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    time,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:black),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
