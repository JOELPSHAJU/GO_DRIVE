part of 'fetch_booking_status_bloc.dart';

@immutable
sealed class FetchBookingStatusEvent {}

final class fetchBookingInitialEvent extends FetchBookingStatusEvent{}