part of 'booking_request_bloc.dart';

@immutable
sealed class BookingRequestState {}

final class BookingRequestInitial extends BookingRequestState {}

final class BookingRequestLoadingState extends BookingRequestState {
  final String message;

  BookingRequestLoadingState({required this.message});
}

final class BookingRequestSuccessStateAccept extends BookingRequestState {
  final String message;

  BookingRequestSuccessStateAccept({required this.message});
}

final class BookingRequestErrorState extends BookingRequestState {
  final String error;

  BookingRequestErrorState({required this.error});
}
