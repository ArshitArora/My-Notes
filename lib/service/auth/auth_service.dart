import 'package:privatenotes/service/auth/auth_provider.dart';
import 'package:privatenotes/service/auth/auth_user.dart';

class AuthService implements AuthProvider{
  final AuthProvider provider;

  AuthService(this.provider);
  
  @override
  Future<AuthUser> createUser({required String email, required String password,}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }
  
  @override
  Future<AuthUser> login({required String email, required String password,}) {
    // TODO: implement login
    throw UnimplementedError();
  }
  
  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
  
  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }
  
  @override
  // TODO: implement user
  AuthUser? get user => throw UnimplementedError();

}