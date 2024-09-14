import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'get_popular_invetories_event.dart';
part 'get_popular_invetories_state.dart';

class GetPopularInvetoriesBloc
    extends Bloc<GetPopularInvetoriesEvent, GetPopularInvetoriesState> {
  GetPopularInvetoriesBloc() : super(GetPopularInvetoriesInitial()) {
    on<GetPopularInvetoriesEventInitial>(_onFetchCarDetails);

  }

  void _onFetchCarDetails(GetPopularInvetoriesEvent event,
      Emitter<GetPopularInvetoriesState> emit) async {
    emit(GetPopularInvetoriesLoading()); 
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Popular').get();

      List<Map<String, dynamic>> carDetails = querySnapshot.docs
          .map((doc) => {
                'documentId': doc.id,
                ...doc.data() as Map<String, dynamic>,
              })
          .toList();

      emit(GetPopularInvetoriesSucess(carDetails: carDetails));
    } catch (e) {
      emit(GetPopularInvetoriesError(message: e.toString()));
    }
  }


}
