import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/view/bloc/add_booking_details/addbookingdetails_bloc.dart';

class PendingOrdersTab extends StatefulWidget {
  const PendingOrdersTab({super.key});

  @override
  State<PendingOrdersTab> createState() => _PendingOrdersTabState();
}

class _PendingOrdersTabState extends State<PendingOrdersTab> {
  @override
  void initState() {
    context
        .read<AddbookingdetailsBloc>()
        .add(BookingInventoryFetchDetailsInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddbookingdetailsBloc, AddbookingdetailsState>(
      builder: (context, state) {
        if (state is GetBookingSuccessState) {
          return ListView.builder(
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              return Padding(
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
                                        "₹${state.data[index]['price']}/-")
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    _buildTableCell('Status'),
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        'PENDING',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 201, 185, 35),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                        )
                      ],
                    )),
              );
            },
          );
        }
        return Center(
          child: Text('No Data Found'),
        );
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
