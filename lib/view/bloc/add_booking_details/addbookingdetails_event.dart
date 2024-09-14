part of 'addbookingdetails_bloc.dart';

@immutable
sealed class AddbookingdetailsEvent {}

class BookingInventoryFetchDetailsInitialEvent extends AddbookingdetailsEvent {}

class AddbookingDetailButtonClickEvent extends AddbookingdetailsEvent {
  final BookingModel data;

  AddbookingDetailButtonClickEvent({required this.data});
}

class BookingInventoryPendingEventFetch extends AddbookingdetailsEvent{}

class BookingInventoryDeleteEvent extends AddbookingdetailsEvent{}