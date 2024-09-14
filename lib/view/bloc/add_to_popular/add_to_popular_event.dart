part of 'add_to_popular_bloc.dart';

@immutable
sealed class AddToPopularEvent {}

final class AddToPopularButtonClickEvent extends AddToPopularEvent {
  final Map<String, dynamic> data;

  AddToPopularButtonClickEvent({required this.data}); 
}
