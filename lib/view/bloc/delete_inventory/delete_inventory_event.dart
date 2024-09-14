part of 'delete_inventory_bloc.dart';

@immutable
sealed class DeleteInventoryEvent {}
final class DeleteInventoryButtonClickEvent extends DeleteInventoryEvent{
  final String inventoryId;

  DeleteInventoryButtonClickEvent({required this.inventoryId});
}