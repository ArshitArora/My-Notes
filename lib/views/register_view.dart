import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privatenotes/constants/routes.dart';
import 'package:privatenotes/service/auth/auth_exception.dart';
import 'package:privatenotes/service/auth/auth_service.dart';
import '../utilities/show_error_dailog.dart';


class RegisterView extends StatefulWidget {
  
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    Firebase.initializeApp();

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
    appBar: AppBar(
      title: const Text('Register Page'),),
     body: Column(
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
                ))
              ,
              TextButton(
                  onPressed: ()async {
                    final email = _email.text;
                    final password = _password.text;
                    
                    try  {
                      await AuthService.firebase().createUser(
                       email: email,
                       password: password
                     );
                          
                    AuthService.firebase().sendEmailVerification();
                    Navigator.of(context).pushNamed(verifyEmailRoute);

                    } 
                    on WeakPasswordFoundException{
                      await showeErrorDialog(
                      context, 'Weak Password, Try Another One (char length min 7'
                      );
                        }

                    on EmailAlreadyInUseFoundException{
                      await showeErrorDialog(
                      context, 'Email alreeady in use, Pleae Enter Another Email.'
                      );
                    }
                    on InvalidEmailException {
                      await showeErrorDialog(
                      context, 'Invalid Email');
                    }
                    on GenericAuthException {
                      await showeErrorDialog(context,
                         'Authentication Error');
                    }


                TextButton(onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
               (route) => false
               );
                }, child: const Text('okay'), 
                );
                  }, child: const Text('Alredy Registed? Go back to the Login Page')
              )
            ],
          ),
   );
  }
}



