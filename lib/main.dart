import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privatenotes/constants/routes.dart';
import 'package:privatenotes/service/auth/auth_service.dart';
import 'package:privatenotes/views/email_verify_view.dart';
import 'package:privatenotes/views/login_views.dart';
import 'package:privatenotes/views/notes_view.dart';
import 'package:privatenotes/views/register_view.dart';

void main() async {
Firebase.initializeApp();
WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
  
        primarySwatch: Colors.green,
      ),
      home: const LoginView(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute:(context) => const NoteView(),
        verifyEmailRoute:(context) => const VerifyEmailView()
      },
    ));
}



class HomePage extends StatelessWidget {
  const HomePage({super.key});

@override
  Widget build(BuildContext context) {
    return FutureBuilder (
        
        future: AuthService.firebase().initialize(),

        builder:(context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:

            final user = AuthService.firebase().currentUser();
            if (user!=null){
              if (user.isemailVerified){
                return const NoteView();
              }
              else {
                return const VerifyEmailView();
              }
            }
            else {
              return const LoginView();
            }
          default:
            return const Text('Loading...');
          }
        }, 
    );
  }
}




