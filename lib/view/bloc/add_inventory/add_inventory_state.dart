part of 'add_inventory_bloc.dart';

@immutable
sealed class AddInventoryState {}

final class AddInventoryInitial extends AddInventoryState {}

final class AddInventoryLoading extends AddInventoryState {}

final class AddInventorySucessState extends AddInventoryState {}

final class AddInventoryErrorState extends AddInventoryState {
  final String error;

  AddInventoryErrorState({required this.error});
}
