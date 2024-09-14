part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}
final class RegisterButtonClickEvent extends RegisterEvent {
  final String email;
  final String password;

  RegisterButtonClickEvent({required this.email, required this.password});
}
