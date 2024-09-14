import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:godrive/controller/repostories/inventory_repo.dart';
// ignore: depend_on_referenced_packages

part 'delete_popular_inventory_event.dart';
part 'delete_popular_inventory_state.dart';

class DeletePopularInventoryBloc
    extends Bloc<DeletePopularInventoryEvent, DeletePopularInventoryState> {
  DeletePopularInventoryBloc() : super(DeletePopularInventoryInitial()) {
    on<GetPopularInvetoriesDeleteEvent>(deletePopularInventory);
  }
  Future<void> deletePopularInventory(GetPopularInvetoriesDeleteEvent event,
      Emitter<DeletePopularInventoryState> emit) async {
    emit(DeletePopularInventoryLoading());
    if (kDebugMode) {
      print(event.docid);
    }
    final String? response =
        await InventoryRepo.deletepopularInventories(event.docid);
    if (response == 'sucess') {
      log('deleted sucessfully');
      emit(DeletePopularInventorySucess());
    } else {
      emit(DeletePopularInventoryError(message: response.toString()));
    }
  }
}
