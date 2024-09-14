part of 'booking_request_bloc.dart';

@immutable
sealed class BookingRequestEvent {}

final class BookingRequestAcceptRejectEvent extends BookingRequestEvent {
  final BookingAcceptRejectModel data;
  final String docId;

  BookingRequestAcceptRejectEvent(this.docId, {required this.data});
}
