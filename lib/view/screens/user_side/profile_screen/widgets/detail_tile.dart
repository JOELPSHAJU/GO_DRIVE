import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({
    super.key,
    required this.size,
    required this.label,
    required this.data,
  });
  final String label;
  final String data;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: white,
            boxShadow: [
              BoxShadow(
                  color: const Color.fromARGB(255, 213, 213, 213),
                  blurRadius: 10,
                  spreadRadius: 8)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: grey, fontSize: 17),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    data,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: black,
                        fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
