

import 'package:bloc/bloc.dart';
import 'package:godrive/controller/login_controller/login_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonClickEvent>(loginButtonClickEvent);
  }

  Future<void> loginButtonClickEvent(
      LoginButtonClickEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final String? response = await LoginUserRepo.loginfunction(
        email: event.email, password: event.password);
    if (response == 'success') {
      emit(LoginSuccess());
    } else {
      emit(LoginError(error: response.toString()));
    }
  }
}
