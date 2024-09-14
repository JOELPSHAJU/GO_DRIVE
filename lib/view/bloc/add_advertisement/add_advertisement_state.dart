part of 'add_advertisement_bloc.dart';


abstract class AdvertisementState {}


class AdvertisementInitial extends AdvertisementState {}

class AdvertisementLoading extends AdvertisementState {}

class AdvertisementFetchSuccess extends AdvertisementState {
  final List<String> imagePaths;
  final List<String> documentIds;

  AdvertisementFetchSuccess(this.imagePaths, this.documentIds);
}

class AdvertisementAddedSuccess extends AdvertisementState {}

class AdvertisementDeletedSuccess extends AdvertisementState {}

class AdvertisementError extends AdvertisementState {
  final String message;

  AdvertisementError(this.message);
}
