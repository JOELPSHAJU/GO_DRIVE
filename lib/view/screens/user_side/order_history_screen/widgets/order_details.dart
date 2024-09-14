import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/constants.dart';
import 'package:godrive/view/screens/universal_widgets/appbar.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key, required this.state});
  final Map<String, dynamic> state;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: const AppbarWidget(title: 'ORDER DETAILS'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: size.width,
          height: size.height,
          color: white,
          child: ListView(
            children: [
              _buildHeader(size),
              const SizedBox(height: 5),
              _buildBillingDetails(size),
              const SizedBox(height: 5),
              _buildInventoryDetails(size),
              const SizedBox(height: 5),
              _buildImage(state['image']),
              const SizedBox(height: 5),
              _buildPaymentDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * .4,
            child: Row(
              children: [
                Image.asset(logoandroid, width: 20),
                w10,
                const Text('GO ',
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 20, color: red)),
                const Text('DRIVE',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: black)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('RENTAL INVOICE',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: black)),
                const SizedBox(height: 5),
                _buildRowText('Pick-up Date', state['pickUpDate']),
                _buildRowText('Drop-off Date', state['dropOffDate']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingDetails(Size size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRowLabel('Bill From', 'Bill To'),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBillDetail(size, 'GO DRIVE, Piravom'),
              _buildBillDetail(size, state['fullName']),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBillDetail(size, '+91 8590182736'),
              _buildBillDetail(size, '+91 ${state['phoneNumber']}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryDetails(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('INVENTORY DETAILS',
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 15, color: black)),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(color: Colors.grey),
            children: [
              _buildTableRow('Company', state['companyName']),
              _buildTableRow('Model', state['modelName']),
              _buildTableRow('Number Plate', state['numberPlate']),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage(String imageUrl) {
    return CachedNetworkImage(imageUrl: imageUrl);
  }

  Widget _buildPaymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('PAYMENT DETAILS',
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 15, color: black)),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(color: Colors.grey),
            children: [
              _buildTableRow('Inventory Amount', '₹${state['price']}/-'),
              _buildTableRow('GST', '₹85/-'),
              _buildTableRow('CGST', '₹12/-'),
              _buildTableRow(
                  'Total Amount', '₹${int.parse(state['price']) + 85 + 12}/-'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRowText(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(value),
      ],
    );
  }

  Widget _buildRowLabel(String leftLabel, String rightLabel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(leftLabel,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 15, color: black)),
          Text(rightLabel,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 15, color: black)),
        ],
      ),
    );
  }

  Widget _buildBillDetail(Size size, String text) {
    return Container(
      width: size.width / 2.25,
      decoration: BoxDecoration(border: Border.all(color: grey)),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: grey80),
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        _buildTableCell(label),
        _buildTableCell(value),
      ],
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
