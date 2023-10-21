import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/core/utils/extensions.dart';
import 'package:todolist/features/auth/data/repositories/auth_repository.dart';
import 'package:todolist/features/auth/data/store/auth_enums.dart';
import 'package:todolist/features/auth/data/store/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(const AuthState());

  /// cubit method to authenticate user --
  void login({required String email, required String password}) async {

    // begin authentication
    emit(state.copyWith(status: AuthStatus.loginInProgress));

    final either = await authRepository.loginWithEmailAndPassword(email: email, password: password);

    // authentication failed
    if(either.isLeft()){
      final l = either.asLeft();
      emit(state.copyWith(status: AuthStatus.loginFailed, message: l));
      return;
    }

    // authentication successful
    emit(state.copyWith(status: AuthStatus.loginSuccessful));

  }

  void logout() async {
    emit(state.copyWith(status: AuthStatus.logoutInProgress));
    await authRepository.logout();
    emit(state.copyWith(status: AuthStatus.logoutCompleted));
  }

}