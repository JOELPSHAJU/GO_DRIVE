import 'package:bloc/bloc.dart';
import 'package:godrive/controller/repostories/profile_repo.dart';
import 'package:meta/meta.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  GetProfileBloc() : super(GetProfileInitial()) {
    on<GetProfileDetailsInitialEvent>(getProfileEvent);
  }
  void getProfileEvent(
      GetProfileDetailsInitialEvent event, Emitter<GetProfileState> emit) async {
    emit(GetProfileLoading());
    try {
      Map<String, dynamic>? documentReference =
          await ProfileRepo.fetchProfileDetails();
      if (documentReference != null) {
        emit(GetProfileSuccess(profile: documentReference));
      } else {
        emit(GetProfileNoData(message: "No Data Found"));
      }
    } catch (e) {
      emit(GetProfileError(message: e.toString()));
    }
  }
}
