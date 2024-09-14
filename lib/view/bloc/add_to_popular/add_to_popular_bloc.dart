import 'package:bloc/bloc.dart';
import 'package:godrive/controller/repostories/inventory_repo.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'add_to_popular_event.dart';
part 'add_to_popular_state.dart';

class AddToPopularBloc extends Bloc<AddToPopularEvent, AddToPopularState> {
  AddToPopularBloc() : super(AddToPopularInitial()) {
    on<AddToPopularButtonClickEvent>(addInventoryButtonClickEvent);
  }
  Future<void> addInventoryButtonClickEvent(AddToPopularButtonClickEvent event,
      Emitter<AddToPopularState> emit) async {
    emit(AddToPopularloadingState());
    final String? response =
        await InventoryRepo.uploadPopularDetails(event.data);
    if (response == 'success') {
      emit(AddToPopularSucessState());
    } else {
      emit(AddToPopularErrorState(error: response.toString()));
    }
  }
}
