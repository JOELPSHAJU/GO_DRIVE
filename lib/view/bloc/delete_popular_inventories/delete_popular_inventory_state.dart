part of 'delete_popular_inventory_bloc.dart';

@immutable
sealed class DeletePopularInventoryState {}

final class DeletePopularInventoryInitial extends DeletePopularInventoryState {}


final class DeletePopularInventoryLoading extends DeletePopularInventoryState {}
final class DeletePopularInventorySucess
    extends DeletePopularInventoryState {}

final class DeletePopularInventoryError extends DeletePopularInventoryState {
  final String message;

  DeletePopularInventoryError({required this.message});
}
