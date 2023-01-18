
import 'package:flutter/material.dart';
import 'package:privatenotes/constants/routes.dart';
import 'package:privatenotes/service/auth/auth_service.dart';
import '../service/auth/auth_exception.dart';
import '../utilities/show_error_dailog.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')
      ),
      body : Column(
        children: [
    
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration : const InputDecoration(
              hintText : 'Enter Your Email Here',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration : const InputDecoration(
              hintText : 'Enter Your Password Here',
            )),
            
          TextButton(
              onPressed: ()async {
                final email = _email.text;
                final password = _password.text;
                
                try  {
                  AuthService.firebase().login(
                    email: email,
                    password: password
                    );
                  
                  final user = AuthService.firebase().currentUser;
                  if (user?.emailVerified ?? false){
                    Navigator.of(context)
                  .pushNamedAndRemoveUntil(notesRoute,
                   (route) => false);
                  }
                  else {
                    Navigator.of(context)
                  .pushNamedAndRemoveUntil(verifyEmailRoute,
                   (route) => false);
                  }
                } 
                on UserNotFoundException{
                  await showeErrorDialog(
                  context, 'User Not Found, Pleae register first.');
                }
                on WrongPasswordFoundException{
                  await showeErrorDialog(
                  context, 'Wrong Password, Try again!');
                }
                on GenericAuthException {
                  showeErrorDialog(
                      context, 
                      'Authentication Error');
                }
              },
              child: const Text('Login'),
        
            ),
            TextButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
               (route) => false
               );
            }, child:
             const Text('Not registered yet?, Register Here!'))
        ],
      ),
    );
  }
}