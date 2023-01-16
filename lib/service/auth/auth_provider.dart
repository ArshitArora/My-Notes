import 'auth_user.dart';

abstract class AuthProvider {
  AuthUser? get user;

  get currentUser => null;
  Future<AuthUser> login({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future <void> logout();
  Future <void> sendEmailVerification();
}