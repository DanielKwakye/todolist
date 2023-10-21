import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todolist/app/routing/route_constants.dart';
import 'package:todolist/core/utils/functions.dart';
import 'package:todolist/features/auth/data/store/auth_cubit.dart';
import 'package:todolist/features/auth/data/store/auth_enums.dart';
import 'package:todolist/features/auth/data/store/auth_state.dart';

class LogoutButtonWidget extends StatelessWidget {

  const LogoutButtonWidget({Key? key}) : super(key: key);

  /// Methods layer
  ///
  void handleLogout(BuildContext context) {
    showConfirmDialog(context, onConfirmTapped: () {
      context.read<AuthCubit>().logout();
    }, title: "Logout!", subtitle: "You'd have to login again the next time you open the app");
  }

  void handleLogoutResponse(BuildContext context, AuthState state) {
    if(state.status == AuthStatus.logoutCompleted){
      context.go(logInPage);
    }
  }

  /// UI layer
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    return BlocListener<AuthCubit, AuthState>(
      listener: handleLogoutResponse,
      child: IconButton(icon: const Icon(FeatherIcons.logOut, size: 18,), color: theme.colorScheme.onBackground,
        onPressed: () => handleLogout(context),),
    );
  }
}

