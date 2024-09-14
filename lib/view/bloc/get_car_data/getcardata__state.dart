abstract class CarDetailsState {}

class CarDetailsLoading extends CarDetailsState {}

class CarDetailsLoaded extends CarDetailsState {
  final List<Map<String, dynamic>> carDetails;

  CarDetailsLoaded(this.carDetails);
}

class CarDetailsError extends CarDetailsState {
  final String error;

  CarDetailsError(this.error);
}
