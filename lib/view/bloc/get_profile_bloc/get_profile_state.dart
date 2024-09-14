part of 'get_profile_bloc.dart';

@immutable
sealed class GetProfileState {}

final class GetProfileInitial extends GetProfileState {}

final class GetProfileLoading extends GetProfileState {}

final class GetProfileSuccess extends GetProfileState {
  final Map<String, dynamic> profile;

  GetProfileSuccess({required this.profile});
}

final class GetProfileNoData extends GetProfileState {
  final String message;

  GetProfileNoData({required this.message});
}

final class GetProfileError extends GetProfileState {
  final String message;

  GetProfileError({required this.message});

}
