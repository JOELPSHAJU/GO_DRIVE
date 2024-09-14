part of 'add_advertisement_bloc.dart';



@immutable
abstract class AdvertisementEvent {}



class FetchAdvertisementsEvent extends AdvertisementEvent {}

class AddAdvertisementEvent extends AdvertisementEvent {
  final XFile image;

  AddAdvertisementEvent({required this.image});
}

class DeleteAdvertisementEvent extends AdvertisementEvent {
  final String documentId;

  DeleteAdvertisementEvent({required this.documentId});
}
