part of 'addbookingdetails_bloc.dart';

@immutable
sealed class AddbookingdetailsState {}

final class AddbookingdetailsInitial extends AddbookingdetailsState {}

final class AddbookingLoadingState extends AddbookingdetailsState {}

final class AddbookingSuccessState extends AddbookingdetailsState {}

final class AddbookingErrorState extends AddbookingdetailsState {
  final String error;

  AddbookingErrorState({required this.error});
}

final class GetBookingSuccessState extends AddbookingdetailsState {
  final List<Map<String, dynamic>> data;

  GetBookingSuccessState({required this.data});
}

final class GetPendingSuccessState extends AddbookingdetailsState {
  final List<Map<String, dynamic>> data;

  GetPendingSuccessState({required this.data});
}
