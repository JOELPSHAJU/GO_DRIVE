part of 'get_popular_invetories_bloc.dart';

@immutable
sealed class GetPopularInvetoriesState {}

final class GetPopularInvetoriesInitial extends GetPopularInvetoriesState {}

final class GetPopularInvetoriesLoading extends GetPopularInvetoriesState{}

final class GetPopularInvetoriesSucess extends GetPopularInvetoriesState{
  final List<Map<String, dynamic>> carDetails;
  GetPopularInvetoriesSucess({required this.carDetails});
}
final class GetPopularInvetoriesError extends GetPopularInvetoriesState{
  final String message;
  GetPopularInvetoriesError({required this.message});
}