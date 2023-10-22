import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:todolist/core/storage/app_storage.dart';
import 'package:todolist/core/utils/functions.dart';
import 'package:todolist/features/auth/data/models/auth_user_model.dart';

class AuthRepository {

  Future<AuthUserModel?> getCurrentUserSession() async {
    //  check if user has accessToken and authUserDetails is set
    AuthUserModel? user  = AppStorage.currentUserSession;

    // return user session if any
    if(user != null) {
      return user;
    }

    // attempt to retrieve user details from pref
    final json = await AppStorage.getFromPref(key: "authUserDetails");

    // if there's no authUserDetails
    if(json == null) {
      return null;
    }

    user = AuthUserModel.fromJson(json);
    AppStorage.currentUserSession = user;

    return user;

  }

  Future<Either<String, AuthUserModel>> loginWithEmailAndPassword({required String email, required String password}) async {

    try{

      if((await isNetworkConnected()) == false){
        return const Left("Kindly check your internet connection");
      }

      // request firebase authentication ----
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      /// once login is successful
      final AuthUserModel userModel = AuthUserModel(email: email);

      // automatically save user to local storage after retrieving
      await AppStorage.saveToPref(key: "authUserDetails", jsonValue: const AuthUserModel().toJson());

      // set authenticated user session
      AppStorage.currentUserSession = userModel;
      return  Right(userModel);


    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        return const Left("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return const Left("Wrong password provided for that user.");
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        debugPrint('Invalid login credentials');
        return const Left("Invalid credentials. Login failed!");
      }
      return Left(e.toString());

    } catch(e) {
      return  Left(e.toString());
    }
  }

  Future<void> logout() async {

    // signOut from the server
    await FirebaseAuth.instance.signOut();

    // remove authUserDetails
    AppStorage.removeFromPref(key: "authUserDetails");

    // remove user from session
    AppStorage.currentUserSession = null;


  }

}
