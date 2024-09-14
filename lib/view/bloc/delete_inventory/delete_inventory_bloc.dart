// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:godrive/controller/repostories/inventory_repo.dart';
import 'package:meta/meta.dart';

part 'delete_inventory_event.dart';
part 'delete_inventory_state.dart';

class DeleteInventoryBloc
    extends Bloc<DeleteInventoryEvent, DeleteInventoryState> {
  DeleteInventoryBloc() : super(DeleteInventoryInitial()) {
    on<DeleteInventoryButtonClickEvent>(deleteInventoryEvent);
  }
  Future<void> deleteInventoryEvent(DeleteInventoryButtonClickEvent event,
      Emitter<DeleteInventoryState> emit) async {
    emit(DeleteBlocLoading());
    final String? response =
        await InventoryRepo.deleteCarDetail(event.inventoryId);
    if (response == 'sucess') {
      log('deleted sucessfully');
      emit(DeleteBlocSuccess());
    } else {
      emit(DeleteBlocError(message: response.toString()));
    }
  }
}
