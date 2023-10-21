import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:separated_column/separated_column.dart';
import 'package:todolist/app/routing/route_constants.dart';
import 'package:todolist/core/mix/form_mixin.dart';
import 'package:todolist/core/utils/constants.dart';
import 'package:todolist/core/utils/enums.dart';
import 'package:todolist/core/utils/extensions.dart';
import 'package:todolist/core/utils/theme.dart';
import 'package:todolist/features/auth/data/store/auth_cubit.dart';
import 'package:todolist/features/auth/data/store/auth_enums.dart';
import 'package:todolist/features/auth/data/store/auth_state.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_button_widget.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_default_logo.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_full_screen_sliver_app_bar.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_page_loading_indicator_widget.dart';
import 'package:todolist/features/shared/presentation/widgets/custom_text_field_widget.dart';

/// This page authenticates user credentials ---

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with FormMixin {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late AuthCubit authCubit;

  @override
  void initState() {

    /// For testing purposes, the email & password are predefined for easier login process
    emailController.text = "dev.invennico@gmail.com";
    passwordController.text = "123456";
    authCubit = context.read<AuthCubit>();
    super.initState();

  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Methods layer -------
  ///
  void handleSubmit(BuildContext ctx) {

    AdaptiveTheme.of(context).setDark();

    //! hide keyboard
    FocusScope.of(context).unfocus();

    // check if all required fields have been filled
    if(!validateAndSaveOnSubmit(ctx)){
      return;
    }
    authCubit.login(email: emailController.text, password: passwordController.text);
  }

  void handleAuthenticationResults (BuildContext context, AuthState state) {
    // when authentication fails
    if(state.status == AuthStatus.loginFailed) {
      context.showSnackBar(state.message);
    }

    // when authentication is successful,
    if(state.status == AuthStatus.loginSuccessful){
      // navigate user to the home page
      context.go(tasksPage);
    }

  }




  /// UI Layer --------
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: handleAuthenticationResults,
        builder: (context, authState) {
          return CustomPageLoadingIndicatorWidget(
            loading: authState.status == AuthStatus.loginInProgress,
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                const CustomFullScreenDialogSliverAppBar(title: "Login", showCloseButton: false,),
                SliverToBoxAdapter(
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 40,),
                        const CustomDefaultLogoWidget(),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Welcome to $kCompanyName!', textAlign: TextAlign.center,
                            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("You've been away too long...",
                            style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontSize: 16
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Text("Login",
                          style: TextStyle(
                              color: theme.colorScheme.onBackground,
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: AnimationConfiguration.synchronized(
                            child: SlideAnimation(
                              duration: const Duration(milliseconds: 800),
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: SeparatedColumn(

                                    separatorBuilder: (BuildContext context, int index) {
                                      return const SizedBox(height: 10,);
                                    },
                                    children: [

                                      CustomTextFieldWidget(
                                        label: 'Email',
                                        controller: emailController,
                                        inputType: TextInputType.emailAddress,
                                        validator: isRequired,
                                        placeHolder: 'yourname@example.com',
                                      ),

                                      CustomTextFieldWidget(
                                        label: 'Password',
                                        controller: passwordController,
                                        isPassword: true,
                                        validator: isRequired,
                                        placeHolder: 'Enter your password here',
                                      ),

                                      Builder(builder: (ctx) {
                                        return CustomButtonWidget(
                                          text: 'Continue with Email ',
                                          expand: true,
                                          icon: const SizedBox(width: 15, child: Icon(Icons.email, size: 18, color: kAppWhite,)),
                                          appearance: Appearance.primary,
                                          textColor: kAppWhite,
                                          onPressed: () => handleSubmit(ctx),
                                        );
                                      })

                                    ]),
                              ),
                            ),

                          ),
                        ),

                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
