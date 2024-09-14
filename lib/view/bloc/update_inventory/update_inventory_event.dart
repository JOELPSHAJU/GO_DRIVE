part of 'update_inventory_bloc.dart';

@immutable
sealed class UpdateInventoryEvent {}

class UpdateCarDetails extends UpdateInventoryEvent {
  final String documentId;
  final CarModel updatedData;
  final String mainimage;
  final List<String> additionalImages;

  UpdateCarDetails(
      {required this.documentId, required this.updatedData,required this.mainimage,required this.additionalImages,});
}
