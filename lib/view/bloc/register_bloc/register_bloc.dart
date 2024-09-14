import 'package:bloc/bloc.dart';
import 'package:godrive/controller/login_controller/login_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonClickEvent>(registerButtonClickEvent);
  }

  Future<void> registerButtonClickEvent(
      RegisterButtonClickEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final String? response = await LoginUserRepo.createUserWithEmailAndPassword(
        email: event.email, password: event.password);
    if (response == 'success') {
      emit(RegisterSuccess());
    } else {
      emit(RegisterError(error: response.toString()));
    }
  }
}
