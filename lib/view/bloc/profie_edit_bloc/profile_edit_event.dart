part of 'profile_edit_bloc.dart';

@immutable
sealed class ProfileEditEvent {}

final class addProfileDetailsEvent extends ProfileEditEvent {
  final ProfileModel data;

  addProfileDetailsEvent({required this.data});
}

final class updateProfileDetailsEvent extends ProfileEditEvent {
  final ProfileModel data;
  final String docId;
  final String profilePictureValue;
  final String coverPictureValue;

  updateProfileDetailsEvent({required this.docId,required this.profilePictureValue,required this.coverPictureValue, required this.data});
}
