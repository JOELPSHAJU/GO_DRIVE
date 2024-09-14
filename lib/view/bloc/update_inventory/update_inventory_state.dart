part of 'update_inventory_bloc.dart';

@immutable
sealed class UpdateInventoryState {}

final class UpdateInventoryInitial extends UpdateInventoryState {}

final class UpdateInventoryLoadingState extends UpdateInventoryState {}

final class UpdateInventorySucessState extends UpdateInventoryState {}

final class UpdateInventoryErrorState extends UpdateInventoryState {
  final String error;

  UpdateInventoryErrorState({required this.error});
}
