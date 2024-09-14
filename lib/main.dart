import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:godrive/firebase_options.dart';
import 'package:godrive/view/bloc/add_advertisement/add_advertisement_bloc.dart';
import 'package:godrive/view/bloc/add_booking_details/addbookingdetails_bloc.dart';
import 'package:godrive/view/bloc/add_inventory/add_inventory_bloc.dart';
import 'package:godrive/view/bloc/add_to_popular/add_to_popular_bloc.dart';
import 'package:godrive/view/bloc/booking_requests/booking_request_bloc.dart';
import 'package:godrive/view/bloc/delete_inventory/delete_inventory_bloc.dart';
import 'package:godrive/view/bloc/delete_popular_inventories/delete_popular_inventory_bloc.dart';
import 'package:godrive/view/bloc/fetch_booking_status/fetch_booking_status_bloc.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata_bloc.dart';
import 'package:godrive/view/bloc/get_popular_inventories/get_popular_invetories_bloc.dart';
import 'package:godrive/view/bloc/get_profile_bloc/get_profile_bloc.dart';
import 'package:godrive/view/bloc/login_bloc/login_bloc.dart';
import 'package:godrive/view/bloc/profie_edit_bloc/profile_edit_bloc.dart';
import 'package:godrive/view/bloc/register_bloc/register_bloc.dart';
import 'package:godrive/view/bloc/rental_rules/rentalrules_bloc.dart';
import 'package:godrive/view/bloc/search_inventory/search_inventory_bloc.dart';
import 'package:godrive/view/bloc/update_inventory/update_inventory_bloc.dart';
import 'package:godrive/view/screens/splash_screen/splash_screen.dart';

// ignore: constant_identifier_names
const SAVE_KEY_NAME = 'IsUserLoggedIn';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => AddInventoryBloc(),
        ),
        BlocProvider(
          create: (context) => CarDetailsBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateInventoryBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteInventoryBloc(),
        ),
        BlocProvider(
          create: (context) => AddToPopularBloc(),
        ),
        BlocProvider(
          create: (context) => GetPopularInvetoriesBloc(),
        ),
        BlocProvider(
          create: (context) => RentalRulesBloc(),
        ),
        BlocProvider(
          create: (context) => DeletePopularInventoryBloc(),
        ),
        BlocProvider(
          create: (context) => AdvertisementBloc(),
        ),
        BlocProvider(
          create: (context) => InventoryBloc(),
        ),
        BlocProvider(
          create: (context) => GetProfileBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileEditBloc(),
        ),
        BlocProvider(
          create: (context) => AddbookingdetailsBloc(),
        ),
        BlocProvider(
          create: (context) => BookingRequestBloc(),
        ),
         BlocProvider(
          create: (context) => FetchBookingStatusBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GO DRIVE',
        home: SplashScreen(),
      ),
    );
  }
}
