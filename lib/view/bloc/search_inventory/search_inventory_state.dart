part of 'search_inventory_bloc.dart';

@immutable
sealed class SearchInventoryState {}

final class SearchInventoryInitial extends SearchInventoryState {}


class InventoryLoading extends SearchInventoryState {}

class InventoryLoaded extends SearchInventoryState {
  final List<dynamic> inventoryList;

  InventoryLoaded(this.inventoryList);
}

class InventoryError extends SearchInventoryState {}
