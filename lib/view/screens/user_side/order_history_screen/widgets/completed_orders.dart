import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/bloc/fetch_booking_status/fetch_booking_status_bloc.dart';
import 'package:godrive/view/screens/user_side/order_history_screen/widgets/order_details.dart';

class CompletedOrdersTab extends StatefulWidget {
  const CompletedOrdersTab({super.key});

  @override
  State<CompletedOrdersTab> createState() => _CompletedOrdersTabState();
}

class _CompletedOrdersTabState extends State<CompletedOrdersTab> {
  @override
  void initState() {
    context.read<FetchBookingStatusBloc>().add(fetchBookingInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchBookingStatusBloc, FetchBookingStatusState>(
      builder: (context, state) {
        if (state is FetchbookingStatusSucessState) {
          return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  state.data[index]['status'] == "accepted"
                      ? Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (s) => OrderDetails(
                                    state: state.data[index],
                                  )))
                      : null;
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          CachedNetworkImage(
                              imageUrl: state.data[index]['image']),
                          h10,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                                border: TableBorder.all(color: Colors.grey),
                                children: [
                                  TableRow(
                                    children: [
                                      _buildTableCell('Pick-up Date'),
                                      _buildTableCell(
                                          state.data[index]['pickUpDate'])
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      _buildTableCell('Drop-off Date'),
                                      _buildTableCell(
                                          state.data[index]['dropOffDate']),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      _buildTableCell('Total Price'),
                                      _buildTableCell(
                                          "₹ ${int.parse(state.data[index]['price']) + 85 + 12}/-")
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      _buildTableCell('Status'),
                                      Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Text(
                                          state.data[index]['status']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: state.data[index]
                                                        ['status'] ==
                                                    'accepted'
                                                ? green50
                                                : red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ]),
                          ),
                          state.data[index]['status'] == "accepted"
                              ? const Center(
                                  child: const Text(
                                    'See Rental Invoice',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: black),
                                  ),
                                )
                              : const SizedBox(),
                          h10
                        ],
                      )),
                ),
              );
            },
          );
        }
        return const Center(child: Text('No data Found'));
      },
    );
  }
}

Widget _buildTableCell(String text) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
