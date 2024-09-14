import 'package:bloc/bloc.dart';
import 'package:godrive/controller/repostories/booking_repo.dart';
import 'package:godrive/model/accept_reject_model.dart';
import 'package:meta/meta.dart';

part 'booking_request_event.dart';
part 'booking_request_state.dart';

class BookingRequestBloc
    extends Bloc<BookingRequestEvent, BookingRequestState> {
  BookingRequestBloc() : super(BookingRequestInitial()) {
    on<BookingRequestAcceptRejectEvent>(acceptRejectevent);
  }

  Future<void> acceptRejectevent(
    BookingRequestAcceptRejectEvent event,
    Emitter<BookingRequestState> emit,
  ) async {
    final String? response =
        await BookingRepo.acceptRejectRequest(event.data, event.docId);
    if (response != null) {
      emit(BookingRequestSuccessStateAccept(message: response.toString()));
    } else {
      emit(BookingRequestErrorState(error: "Something went wrong"));
    }
  }
}
