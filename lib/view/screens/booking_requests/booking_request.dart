import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/model/accept_reject_model.dart';
import 'package:godrive/view/bloc/add_booking_details/addbookingdetails_bloc.dart';
import 'package:godrive/view/bloc/booking_requests/booking_request_bloc.dart';
import 'package:godrive/view/screens/universal_widgets/appbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookingRequest extends StatefulWidget {
  const BookingRequest({super.key});

  @override
  State<BookingRequest> createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  @override
  void initState() {
    super.initState();
    context
        .read<AddbookingdetailsBloc>()
        .add(BookingInventoryPendingEventFetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarWidget(title: 'BOOKING REQUESTS'),
      backgroundColor: Colors.grey.shade300,
      body: MultiBlocListener(
        listeners: [
          BlocListener<BookingRequestBloc, BookingRequestState>(
            listener: (context, state) {
              if (state is BookingRequestSuccessStateAccept) {
                context
                    .read<AddbookingdetailsBloc>()
                    .add(BookingInventoryPendingEventFetch());
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Request ${state.message}'.toUpperCase()),
                    backgroundColor:
                        state.message == 'accepted' ? green50 : red,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AddbookingdetailsBloc, AddbookingdetailsState>(
          builder: (context, state) {
            if (state is AddbookingLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetPendingSuccessState) {
              final data = state.data;

              if (data.isEmpty) {
                return const Center(child: Text('No Data Found'));
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];

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
                            imageUrl: item['image'] ?? '',
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Table(
                              border: TableBorder.all(color: Colors.grey),
                              children: [
                                TableRow(
                                  children: [
                                    _buildTableCell('Pick-up Date'),
                                    _buildTableCell(
                                        item['pickUpDate'] ?? 'N/A'),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    _buildTableCell('Drop-off Date'),
                                    _buildTableCell(
                                        item['dropOffDate'] ?? 'N/A'),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    _buildTableCell('Total Price'),
                                    _buildTableCell(
                                        "₹${item['price'] ?? '0'}/-"),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8, bottom: 8),
                            child: MaterialButton(
                              height: 40,
                              minWidth: 180,
                              child: const Text('Show Details'),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.grey.shade300,
                              onPressed: () {
                                _showBookingDetailsPopup(context, item);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is AddbookingErrorState) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('Unexpected State'));
            }
          },
        ),
      ),
    );
  }
}

void _showBookingDetailsPopup(BuildContext context, Map<String, dynamic> item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: white,
        shape: const ContinuousRectangleBorder(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'BOOKING DETAILS',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Container(
              width: 30,
              color: red,
              height: 30,
              child: Stack(
                children: [
                  Positioned(
                    top: -8,
                    left: -8,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                          color: white,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  border: TableBorder.all(color: Colors.grey),
                  children: [
                    TableRow(
                      children: [
                        _buildTableCell('Inventory'),
                        _buildTableCell(
                            "${item['companyName'] + ' ' + item['modelName'] ?? '0'}"),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Number Plate'),
                        _buildTableCell("${item['numberPlate'] ?? '0'}"),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Pick-up Date'),
                        _buildTableCell(item['pickUpDate'] ?? 'N/A'),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Drop-off Date'),
                        _buildTableCell(item['dropOffDate'] ?? 'N/A'),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Total Price'),
                        _buildTableCell("₹${item['price'] ?? '0'}/-"),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Full Name'),
                        _buildTableCell("${item['fullName'] ?? '0'}"),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Phone Number'),
                        _buildTableCell("${item['phoneNumber'] ?? '0'}"),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Email Address'),
                        _buildTableCell("${item['emailAddress'] ?? '0'}"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CachedNetworkImage(
                imageUrl: item['image'] ?? '',
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ],
          ),
        ),
        actions: [
          _buildActionButtons(context, item, 'rejected', red),
          _buildActionButtons(context, item, 'accepted', green50),
        ],
      );
    },
  );
}

Widget _buildActionButtons(BuildContext context, Map<String, dynamic> item,
    String status, Color color) {
  return BlocConsumer<BookingRequestBloc, BookingRequestState>(
    listener: (context, state) {},
    builder: (context, state) {
      if (state is BookingRequestLoadingState) {
        return MaterialButton(
          onPressed: () {},
          minWidth: 120,
          height: 40,
          color: black,
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: white,
              size: 40,
            ),
          ),
        );
      }
      return MaterialButton(
        minWidth: 120,
        height: 40,
        color: color,
        child: Text(
          status.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.w500, color: white),
        ),
        onPressed: () {
          final BookingAcceptRejectModel data = BookingAcceptRejectModel(
            companyName: item['companyName'],
            modelName: item['modelName'],
            dropoffdate: item['dropOffDate'],
            emailAddress: item['emailAddress'],
            fullName: item['fullName'],
            price: item['price'],
            phoneNumber: item['phoneNumber'],
            image: item['image'],
            profilePicture: item['profilePicture'],
            status: status,
            numberplate: item['numberPlate'],
            pickupdate: item['pickUpDate'],
          );
          context.read<BookingRequestBloc>().add(
              BookingRequestAcceptRejectEvent(data: data, item['documentId']));
        },
      );
    },
  );
}

TableCell _buildTableCell(String value) {
  return TableCell(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value,
        style: const TextStyle(fontSize: 14),
      ),
    ),
  );
}
