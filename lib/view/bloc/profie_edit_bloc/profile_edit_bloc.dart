import 'package:bloc/bloc.dart';
import 'package:godrive/controller/repostories/profile_repo.dart';
import 'package:godrive/model/user_profile_model.dart';
import 'package:meta/meta.dart';

part 'profile_edit_event.dart';
part 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  ProfileEditBloc() : super(ProfileEditInitial()) {
    on<addProfileDetailsEvent>(addprofileEvent);
    on<updateProfileDetailsEvent>(updateprofileEvent);
  }
  Future<void> addprofileEvent(
      addProfileDetailsEvent event, Emitter<ProfileEditState> emit) async {
    emit(ProfileEditLoading());
    final String? response = await ProfileRepo.uploadProfileDetails(event.data);
    if (response == 'success') {
      emit(ProfileEditSuccess());
    } else {
      emit(ProfileEditError(error: response.toString()));
    }
  }

  Future<void> updateprofileEvent(
      updateProfileDetailsEvent event, Emitter<ProfileEditState> emit) async {
    emit(ProfileEditLoading());
    final String? response = await ProfileRepo.updateProfileDetails(event.data,
        event.docId, event.profilePictureValue, event.coverPictureValue);
    if (response == 'success') {
      emit(ProfileEditSuccess());
    } else {
      emit(ProfileEditError(error: response.toString()));
    }
  }
}
