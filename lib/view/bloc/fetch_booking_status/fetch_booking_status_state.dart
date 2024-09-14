part of 'fetch_booking_status_bloc.dart';

@immutable
sealed class FetchBookingStatusState {}

final class FetchBookingStatusInitial extends FetchBookingStatusState {}

final class FetchbookingStatusLoadingState extends FetchBookingStatusState {}

final class FetchbookingStatusSucessState extends FetchBookingStatusState {
  final List<Map<String, dynamic>> data;

  FetchbookingStatusSucessState({required this.data});
}

final class FetchbookingStatusErrorState extends FetchBookingStatusState {
  final String error;

  FetchbookingStatusErrorState({required this.error});
}
