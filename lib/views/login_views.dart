
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privatenotes/constants/routes.dart';
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
                  await FirebaseAuth.instance.
                  signInWithEmailAndPassword(
                  email: email, 
                  password: password,
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                  .pushNamedAndRemoveUntil(notesRoute,
                   (route) => false);
                } 
                on FirebaseAuthException catch (e){
                  if (e.code == 'user-not-found'){
                    await showeErrorDialog(
                      context, 'User Not Found, Pleae register first.');
                    }
                  else if (e.code == 'wrong-password'){
                    await showeErrorDialog(
                      context, 'Wrong Password, Try again!');
                  }
                  else {
                    showeErrorDialog(
                      context, 
                      'Error: ${e.code}');
                  }
                }
                catch (e) {
                  showeErrorDialog(
                      context, 
                      e.toString());
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