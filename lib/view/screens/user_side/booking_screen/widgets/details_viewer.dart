 import 'package:flutter/material.dart';

Widget buildDetailsTable(Map<String, dynamic> data) {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      children: [
        TableRow(
          children: [
            _buildTableCell('Category'),
            _buildTableCell(data['category']),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Engine Displacement'),
            _buildTableCell('${data['engineDisplacement']} cc'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Max Power'),
            _buildTableCell('${data['maxPower']} hp'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Max Torque'),
            _buildTableCell('${data['maxTorque']} nm'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Transmission'),
            _buildTableCell(data['transmissionType']),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Gearbox'),
            _buildTableCell('${data['gearbox']} speed'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('0-100 km/h'),
            _buildTableCell('${data['zeroToHundred']} seconds'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Fuel Type'),
            _buildTableCell(data['fuelType']),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Fuel Tank Capacity'),
            _buildTableCell('${data['fuelTankCapacity']} ltrs'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Seating Capacity'),
            _buildTableCell('${data['seatingCapacity']} person'),
          ],
        ),
        TableRow(
          children: [
            _buildTableCell('Ground Clearance'),
            _buildTableCell('${data['groundClearance']} mm'),
          ],
        ),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
