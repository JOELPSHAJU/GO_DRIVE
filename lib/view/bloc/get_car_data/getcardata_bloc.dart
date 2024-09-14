import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata_event.dart';
import 'package:godrive/view/bloc/get_car_data/getcardata__state.dart';

class CarDetailsBloc extends Bloc<CarDetailsEvent, CarDetailsState> {
  CarDetailsBloc() : super(CarDetailsLoading()) {
    on<FetchCarDetails>(_onFetchCarDetails);
  }

  void _onFetchCarDetails(
      FetchCarDetails event, Emitter<CarDetailsState> emit) async {
    emit(CarDetailsLoading());
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('CarDetails').get();

      List<Map<String, dynamic>> carDetails = querySnapshot.docs
          .map((doc) => {
                'documentId': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();

      emit(CarDetailsLoaded(carDetails));
    } catch (e) {
      emit(CarDetailsError(e.toString()));
    }
  }
}
