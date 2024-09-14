// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:godrive/controller/repostories/inventory_repo.dart';
import 'package:godrive/model/car_model.dart';
import 'package:meta/meta.dart';

part 'add_inventory_event.dart';
part 'add_inventory_state.dart';

class AddInventoryBloc extends Bloc<AddInventoryEvent, AddInventoryState> {

  AddInventoryBloc() : super(AddInventoryInitial()) {
    on<AddInventoryButtonClickEvent>(addInventoryButtonClickEvent);
  }

  Future<void> addInventoryButtonClickEvent(AddInventoryButtonClickEvent event,
      Emitter<AddInventoryState> emit) async {
    emit(AddInventoryLoading());
    final String? response =
        await InventoryRepo.uploadCarDetails(event.cardetails);
    if (response == 'success') {
      emit(AddInventorySucessState());
    } else {
      emit(AddInventoryErrorState(error: response.toString()));
    }
  }
}
