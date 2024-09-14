part of 'add_to_popular_bloc.dart';

@immutable
sealed class AddToPopularState {}

final class AddToPopularInitial extends AddToPopularState {}

final class AddToPopularloadingState extends AddToPopularState {}

final class AddToPopularSucessState extends AddToPopularState {}

final class AddToPopularErrorState extends AddToPopularState {
  final String error;

  AddToPopularErrorState({required this.error});
}
