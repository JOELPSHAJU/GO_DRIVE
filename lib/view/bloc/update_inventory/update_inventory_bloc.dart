// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:godrive/controller/repostories/inventory_repo.dart';
import 'package:godrive/model/car_model.dart';
import 'package:meta/meta.dart';

part 'update_inventory_event.dart';
part 'update_inventory_state.dart';

class UpdateInventoryBloc
    extends Bloc<UpdateInventoryEvent, UpdateInventoryState> {
  UpdateInventoryBloc() : super(UpdateInventoryInitial()) {
    on<UpdateCarDetails>(updateCarDetails);
  }
  Future<void> updateCarDetails(
      UpdateCarDetails event, Emitter<UpdateInventoryState> emit) async {
    emit(UpdateInventoryLoadingState());
    final String? response = await InventoryRepo.updateCarDetails(
        event.updatedData,
        event.documentId,
        event.mainimage,
        event.additionalImages);
    if (response == 'success') {
      emit(UpdateInventorySucessState());
    } else {
      emit(UpdateInventoryErrorState(error: response.toString()));
    }
  }
}
