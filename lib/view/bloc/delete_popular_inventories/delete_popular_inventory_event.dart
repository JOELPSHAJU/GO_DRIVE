part of 'delete_popular_inventory_bloc.dart';

@immutable
sealed class DeletePopularInventoryEvent {}
final class GetPopularInvetoriesDeleteEvent extends DeletePopularInventoryEvent {
  final String docid;

  GetPopularInvetoriesDeleteEvent({required this.docid});
}
