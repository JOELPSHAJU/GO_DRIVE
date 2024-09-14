part of 'add_inventory_bloc.dart';

@immutable
sealed class AddInventoryEvent {}

final class AddInventoryButtonClickEvent extends AddInventoryEvent {
  final CarModel cardetails;
  AddInventoryButtonClickEvent({required this.cardetails});


  
}
