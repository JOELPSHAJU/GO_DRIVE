import 'package:bloc/bloc.dart';
import 'package:godrive/controller/repostories/booking_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_booking_status_event.dart';
part 'fetch_booking_status_state.dart';

class FetchBookingStatusBloc
    extends Bloc<FetchBookingStatusEvent, FetchBookingStatusState> {
  FetchBookingStatusBloc() : super(FetchBookingStatusInitial()) {
    on<fetchBookingInitialEvent>(fetchInitialEvent);
  }
  Future<void> fetchInitialEvent(fetchBookingInitialEvent event,
      Emitter<FetchBookingStatusState> emit) async {
    emit(FetchbookingStatusLoadingState());
    try {
      List<Map<String, dynamic>>? response =
          await BookingRepo.fetchbookingacceptrejectuser();
      if (response != null) {
        emit(FetchbookingStatusSucessState(data: response));
      } else {
        emit(FetchbookingStatusErrorState(error: 'Some Error Happened'));
      }
    } catch (e) {
      emit(FetchbookingStatusErrorState(error: e.toString()));
    }
  }
}
