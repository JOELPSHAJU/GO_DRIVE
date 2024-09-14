import 'package:bloc/bloc.dart';
import 'package:godrive/controller/repostories/booking_repo.dart';
import 'package:godrive/controller/repostories/inventory_repo.dart';
import 'package:godrive/model/booking_model.dart';
import 'package:meta/meta.dart';

part 'addbookingdetails_event.dart';
part 'addbookingdetails_state.dart';

class AddbookingdetailsBloc
    extends Bloc<AddbookingdetailsEvent, AddbookingdetailsState> {
  AddbookingdetailsBloc() : super(AddbookingdetailsInitial()) {
    on<AddbookingDetailButtonClickEvent>(addbookingevent);
    on<BookingInventoryFetchDetailsInitialEvent>(getDataEvent);
    on<BookingInventoryPendingEventFetch>(getPendingDataEvent);
  }
  Future<void> addbookingevent(AddbookingDetailButtonClickEvent event,
      Emitter<AddbookingdetailsState> emit) async {
    emit(AddbookingLoadingState());
    final String? response = await BookingRepo.uploadbookingdetails(event.data);
    if (response == 'success') {
      emit(AddbookingSuccessState());
    } else {
      emit(AddbookingErrorState(error: response.toString()));
    }
  }

  Future<void> getDataEvent(BookingInventoryFetchDetailsInitialEvent event,
      Emitter<AddbookingdetailsState> emit) async {
    emit(AddbookingLoadingState());
    try {
      List<Map<String, dynamic>>? response =
          await BookingRepo.fetchPendingOrders();

      if (response != null) {
        emit(GetBookingSuccessState(data: response));
      } else {
        emit(AddbookingErrorState(error: 'Failed to fetch data'));
      }
    } catch (e) {
      emit(AddbookingErrorState(error: e.toString()));
    }
  }

  Future<void> getPendingDataEvent(BookingInventoryPendingEventFetch event,
      Emitter<AddbookingdetailsState> emit) async {
    emit(AddbookingLoadingState());
    try {
      List<Map<String, dynamic>>? response =
          await BookingRepo.fetchAllPendingOrders();

      if (response != null) {
        emit(GetPendingSuccessState(data: response));
      } else {
        emit(AddbookingErrorState(error: 'No pending orders found.'));
      }
    } catch (e) {
      emit(AddbookingErrorState(error: e.toString()));
    }
  }
}
