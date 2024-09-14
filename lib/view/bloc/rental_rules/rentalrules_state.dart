// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

@immutable
abstract class RentalRulesState {}

class RentalRulesInitial extends RentalRulesState {}

class RentalRulesLoading extends RentalRulesState {}

class RentalRulesLoaded extends RentalRulesState {
  final List<Map<String, dynamic>> rules;
  RentalRulesLoaded({required this.rules});
}

class RentalRulesError extends RentalRulesState {
  final String message;
  RentalRulesError({required this.message});
}
