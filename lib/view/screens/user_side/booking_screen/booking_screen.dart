import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/core/snakbars.dart';
import 'package:godrive/model/booking_model.dart';
import 'package:godrive/view/bloc/add_booking_details/addbookingdetails_bloc.dart';
import 'package:godrive/view/screens/universal_widgets/appbar.dart';
import 'package:godrive/view/screens/universal_widgets/loading_button.dart';

import 'package:godrive/view/screens/user_side/booking_screen/widgets/details_viewer.dart';
import 'package:godrive/view/screens/user_side/booking_screen/widgets/personal_details_table.dart';
import 'package:godrive/view/screens/user_side/booking_screen/widgets/time_picker_widget.dart';
import 'package:godrive/view/screens/user_side/profile_screen/profile_screen.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BookingScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final ValueNotifier<String> pickupDate =
      ValueNotifier<String>(DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final ValueNotifier<String> dropOffDate = ValueNotifier<String>(
      DateFormat('dd/MM/yyyy')
          .format(DateTime.now().add(const Duration(days: 1))));
  TextEditingController phonenumberController = TextEditingController();
  BookingScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppbarWidget(title: 'BOOK INVENTORY'),
      body: BlocListener<AddbookingdetailsBloc, AddbookingdetailsState>(
        listener: (context, state) {
          if (state is AddbookingSuccessState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: green50,
                content: Text('Booking Request Sent'),
              ),
            );
          } else if (state is AddbookingErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: red,
                content: Text(state.error),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: 100,
                  child: CachedNetworkImage(
                    imageUrl: data['mainImage'],
                    height: 80,
                  ),
                ),
                h20,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${data['companyName']} ${data['modelName']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                h20,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Technical Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        decoration: TextDecoration.underline),
                  ),
                ),
                h10,
                buildDetailsTable(data),
                h20,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Schedule Time Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        decoration: TextDecoration.underline),
                  ),
                ),
                h10,
                _buildTimePickerWidget(
                  context,
                  title: 'Pickup Date',
                  size: size,
                  selectedDate: pickupDate,
                  isPickupDate: true,
                ),
                h20,
                _buildTimePickerWidget(
                  context,
                  title: 'Drop-off Date',
                  size: size,
                  selectedDate: dropOffDate,
                  isPickupDate: false,
                ),
                h20,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Location Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        decoration: TextDecoration.underline),
                  ),
                ),
                h10,
                _buildLocationDetails(size),
                h20,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Personal Details',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        decoration: TextDecoration.underline),
                  ),
                ),
                h10,
                PersonalDetailsTable(),
                h20,
                ValueListenableBuilder<String>(
                  valueListenable: pickupDate,
                  builder: (context, pickupValue, child) {
                    return ValueListenableBuilder<String>(
                      valueListenable: dropOffDate,
                      builder: (context, dropOffValue, child) {
                        final pickup =
                            DateFormat('dd/MM/yyyy').parse(pickupValue);
                        final dropOff =
                            DateFormat('dd/MM/yyyy').parse(dropOffValue);
                        final int days = dropOff.difference(pickup).inDays;
                        final double pricePerDay =
                            double.parse(data['pricePerDay']);
                        final double totalPrice = days * pricePerDay;

                        return Text(
                          'Total Price: ₹${totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    );
                  },
                ),
                h20,
                BlocBuilder<AddbookingdetailsBloc, AddbookingdetailsState>(
                  builder: (context, state) {
                    if (state is AddbookingLoadingState) {
                      return loadingButton(
                          media: size, onPressed: () {}, color: black);
                    }
                    return MaterialButton(
                      color: black,
                      minWidth: MediaQuery.of(context).size.width,
                      height: 55,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      onPressed: () {
                        final bookingdata = BookingModel(
                            companyName: data['companyName'],
                            modelName: data['modelName'],
                            dropoffdate: dropOffDate.value,
                            emailAddress: currentUser!.email.toString(),
                            fullName: userdata.fullName,
                            profilePicture: userdata.profilePicture,
                            numberplate: data['numberPlate'],
                            phoneNumber: userdata.phoneNumber,
                            pickupdate: pickupDate.value,
                            price: data['pricePerDay'],
                            image: data['mainImage']);
                        context.read<AddbookingdetailsBloc>().add(
                            AddbookingDetailButtonClickEvent(
                                data: bookingdata));
                      },
                      child: const Text('Book Now',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: white,
                              fontSize: 17)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationDetails(Size size) {
    return Column(
      children: [
        _buildLocationRow(size, 'Pickup Location : ',
            'GO DRIVE, Pallikavala, Piravom, Kerala 686664'),
        h10,
        _buildLocationRow(size, 'Drop-Off Location : ',
            'GO DRIVE, Pallikavala, Piravom, Kerala 686664'),
      ],
    );
  }

  Widget _buildLocationRow(Size size, String title, String location) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: size.width,
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: .7)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Expanded(
                child: Text(
                  location,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: darkgrey,
                      fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePickerWidget(
    BuildContext context, {
    required String title,
    required Size size,
    required ValueNotifier<String> selectedDate,
    required bool isPickupDate,
  }) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedDate,
      builder: (context, value, child) {
        return TimepickerWidget(
          time: value,
          title: title,
          size: size,
          onTap: () => showModalBottomSheet(
            backgroundColor: white,
            context: context,
            builder: (context) {
              return SizedBox(
                width: size.width,
                height: 280,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      DatePickerWidget(
                        initialDateTime: DateFormat('dd/MM/yyyy').parse(value),
                        onChange: (dateTime, selectedIndex) {},
                        onConfirm: (dateTime, _) {
                          final formattedDate =
                              DateFormat('dd/MM/yyyy').format(dateTime);
                          if (!isPickupDate) {
                            final pickup = DateFormat('dd/MM/yyyy')
                                .parse(pickupDate.value);
                            if (dateTime.isBefore(
                                pickup.add(const Duration(days: 1)))) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Select at least a 1-day duration'),
                                ),
                              );
                            } else {
                              selectedDate.value = formattedDate;
                            }
                          } else {
                            pickupDate.value = formattedDate;

                            final dropOff = DateFormat('dd/MM/yyyy')
                                .parse(dropOffDate.value);
                            if (dropOff.isBefore(
                                dateTime.add(const Duration(days: 1)))) {
                              dropOffDate.value = DateFormat('dd/MM/yyyy')
                                  .format(
                                      dateTime.add(const Duration(days: 1)));
                            }
                          }
                        },
                        // Minimum date should be today or after for pickup
                        minDateTime: isPickupDate
                            ? DateTime.now()
                            : DateFormat('dd/MM/yyyy')
                                .parse(pickupDate.value)
                                .add(const Duration(days: 1)),
                        // Max date is 7 days from pickup
                        maxDateTime: isPickupDate
                            ? null
                            : DateFormat('dd/MM/yyyy')
                                .parse(pickupDate.value)
                                .add(const Duration(days: 7)),
                        pickerTheme: DateTimePickerTheme(
                          itemHeight: 60,
                          cancelTextStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                          itemTextStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: black,
                          ),
                          confirmTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: green50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
