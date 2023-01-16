
import 'package:privatenotes/service/auth/auth_exception.dart';
import 'package:privatenotes/service/auth/auth_user.dart';
import 'package:privatenotes/service/auth/auth_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

  // show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email, 
    required String password,
    }) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, 
        password: password,
        );
        final user = currentUser;
        if (user != null){
          return user;
        }
        else {
          throw UserNotLggedInAuthException();
        }
    } on FirebaseAuthException catch (e){
      if (e.code == 'email-already-in-use'){
        throw EmailAlreadyInUseFoundException();
      }
      else if (e.code == 'weak-password'){
        throw WeakPasswordFoundException();
      }
      else if (e.code == 'invalid-email'){
        throw InvalidEmailException();
      } 
      else {
        throw GenericAuthException();
      }

    } catch (_){
      throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
    }) async {
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
          );
          final user = currentUser;
        if (user != null){
          return user;
        }
        else {
          throw UserNotLggedInAuthException();
        }
      } on FirebaseAuthException catch (e){
          if (e.code == 'user-not-found'){
            throw UserNotFoundException();
          }
          else if (e.code == 'wrong-password'){
            throw WrongPasswordFoundException();
          }
          else {
            throw GenericAuthException();
          }
          }
          catch (_){
            throw GenericAuthException();
          }
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() async  {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      await user.sendEmailVerification();
    }
      throw UserNotLggedInAuthException();
  }

  @override
  AuthUser? get currentUser  {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null){
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }
  
  @override
  // TODO: implement user
  AuthUser? get user => throw UnimplementedError();

}