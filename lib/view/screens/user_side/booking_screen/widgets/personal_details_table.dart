import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/core/colors.dart';
import 'package:godrive/model/user_profile_model.dart';
import 'package:godrive/view/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:godrive/view/screens/user_side/profile_screen/profile_screen.dart';

ProfileModel userdata = ProfileModel(
    fullName: '',
    phoneNumber: '',
    profilePicture: '',
    coverPicture: '',
    address: '',
    pincode: '');

class PersonalDetailsTable extends StatefulWidget {
  const PersonalDetailsTable({super.key});

  @override
  State<PersonalDetailsTable> createState() => _PersonalDetailsTableState();
}

class _PersonalDetailsTableState extends State<PersonalDetailsTable> {
  @override
  void initState() {
    context.read<GetProfileBloc>().add(GetProfileDetailsInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileBloc, GetProfileState>(
      builder: (context, state) {
        if (state is GetProfileSuccess) {
          userdata = ProfileModel(
            address: state.profile['address'],
            fullName: state.profile['fullName'],
            phoneNumber: state.profile['phoneNumber'],
            pincode: state.profile['pincode'],
            profilePicture: state.profile['profilePicture'],
            coverPicture: state.profile['coverPicture'],
          );
          return Table(
            border: TableBorder.all(color: Colors.grey),
            children: [
              TableRow(
                children: [
                  _buildTableCell('Full Name'),
                  _buildTableCell(state.profile['fullName']),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell('Email Address'),
                  _buildTableCell(currentUser!.email.toString()),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell('Phone Number'),
                  _buildTableCell(state.profile['phoneNumber']),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell('Address'),
                  _buildTableCell(state.profile['address']),
                ],
              ),
              TableRow(
                children: [
                  _buildTableCell('Pincode'),
                  _buildTableCell(state.profile['pincode']),
                ],
              ),
            ],
          );
        }
        return const Align(
          alignment: Alignment.center,
          child: Text(
            'Please Update Your Profile',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
        );
      },
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
}
