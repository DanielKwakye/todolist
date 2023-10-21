import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:todolist/features/auth/data/store/auth_enums.dart';

part 'auth_state.g.dart';

@CopyWith()
class AuthState extends Equatable {
  final AuthStatus status;
  final String message;

  const AuthState({
    this.status = AuthStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [status];

}