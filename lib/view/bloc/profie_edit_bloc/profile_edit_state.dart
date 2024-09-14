part of 'profile_edit_bloc.dart';

@immutable
sealed class ProfileEditState {}

final class ProfileEditInitial extends ProfileEditState {}

final class ProfileEditLoading extends ProfileEditState {}
final class ProfileEditSuccess extends ProfileEditState {}
final class ProfileEditFailure extends ProfileEditState {}
final class ProfileEditError extends ProfileEditState {
  final String error;
  ProfileEditError({required this.error});
}
