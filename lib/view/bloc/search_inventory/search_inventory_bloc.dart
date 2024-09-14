import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'search_inventory_event.dart';
part 'search_inventory_state.dart';

class InventoryBloc extends Bloc<SearchInventoryEvent, SearchInventoryState> {
  List<Map<String, dynamic>> _allResults = [];
  String id = '';

  InventoryBloc() : super(InventoryLoading()) {
    on<FetchInventoryEvent>(_onFetchInventory);
    on<SearchInventory>(_onSearchInventory);
    on<AddToFavourites>(_onAddToFavourites);
    on<RemoveFromFavourites>(_onRemoveFromFavourites);
  }

  Future<void> _onFetchInventory(
      FetchInventoryEvent event, Emitter<SearchInventoryState> emit) async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('CarDetails')
          .orderBy('category')
          .get();

      _allResults = data.docs.map((doc) {
        return {
          ...doc.data(),
          'id': doc.id,
        };
      }).toList();

      emit(InventoryLoaded(_allResults));
    } catch (e) {
      emit(InventoryError());
    }
  }

  void _onSearchInventory(
      SearchInventory event, Emitter<SearchInventoryState> emit) {
    if (event.query.isEmpty) {
      emit(InventoryLoaded(_allResults));
    } else {
      var searchResults = _allResults.where((map) {
        var modelName = map['modelName'].toString().toLowerCase();
        var companyName = map['companyName'].toString().toLowerCase();
        var categoryName = map['category'].toString().toLowerCase();

        return modelName.contains(event.query.toLowerCase()) ||
            companyName.contains(event.query.toLowerCase()) ||
            categoryName.contains(event.query.toLowerCase());
      }).toList();

      emit(InventoryLoaded(searchResults));
    }
  }

  Future<void> _onAddToFavourites(
      AddToFavourites event, Emitter<SearchInventoryState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection('CarDetails')
          .doc(event.documentId)
          .update({
        'favourites': FieldValue.arrayUnion([event.email])
      });
      add(FetchInventoryEvent()); 
    } catch (e) {
      emit(InventoryError());
    }
  }

  Future<void> _onRemoveFromFavourites(
      RemoveFromFavourites event, Emitter<SearchInventoryState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection('CarDetails')
          .doc(event.documentId)
          .update({
        'favourites': FieldValue.arrayRemove([event.email])
      });
      add(FetchInventoryEvent()); 
    } catch (e) {
      emit(InventoryError());
    }
  }
}
