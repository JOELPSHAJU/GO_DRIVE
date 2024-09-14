part of 'get_profile_bloc.dart';

@immutable
sealed class GetProfileEvent {}

final class GetProfileDetailsInitialEvent extends GetProfileEvent {}
