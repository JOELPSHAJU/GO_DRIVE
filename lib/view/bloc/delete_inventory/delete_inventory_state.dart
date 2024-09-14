part of 'delete_inventory_bloc.dart';

@immutable
sealed class DeleteInventoryState {}

final class DeleteInventoryInitial extends DeleteInventoryState {}


final class DeleteBlocLoading extends DeleteInventoryState {}

final class DeleteBlocSuccess extends DeleteInventoryState {}

final class DeleteBlocError extends DeleteInventoryState {
  final String message;
   DeleteBlocError({required this.message});
}
