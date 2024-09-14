part of 'search_inventory_bloc.dart';

@immutable
sealed class SearchInventoryEvent {}


class FetchInventoryEvent extends SearchInventoryEvent {}

class SearchInventory extends SearchInventoryEvent {
  final String query;

  SearchInventory(this.query);
}

class AddToFavourites extends SearchInventoryEvent {
  final String documentId; 
  final String email;

  AddToFavourites(this.documentId, this.email);
}

class RemoveFromFavourites extends SearchInventoryEvent {
  final String documentId;
  final String email;

  RemoveFromFavourites(this.documentId, this.email);
}