import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:privatenotes/constants/routes.dart';
import 'package:privatenotes/views/email_verify_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:privatenotes/views/login_views.dart';
import 'package:privatenotes/views/register_view.dart';
import 'firebase_options.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();
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
        
        future: Firebase.initializeApp(
                   options: DefaultFirebaseOptions.currentPlatform,
                  ),

        builder:(context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.done:

            final user = FirebaseAuth.instance.currentUser;
            if (user!=null){
              if (user.emailVerified){
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

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

enum MenuAction {logout}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Home UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async{
              switch(value){
                case MenuAction.logout:
                final shouldlogout = await showLogOutdialog(context);
                if(shouldlogout){
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                   (_) => false,
                   );
                }
              
              }
            },
            itemBuilder: (context) {
              return const[
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log Out'),
                )
              ];
            },
          ) 
        ],
      ),
      body: Column(children: [
        const Text('Hello World')
      ]
      ),
    );
  }
}

Future<bool> showLogOutdialog(BuildContext context){
  return showDialog<bool>(
    context: context, 
    builder: (context){
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton
          (onPressed: () {
            Navigator.of(context).pop(false);
          },
           child: const Text('Cancel')),
          TextButton
          (onPressed: () {
            Navigator.of(context).pop(true);
          },
           child: const Text('Log Out'))
        ],
      );
    },
    ).then((value) => value ?? false);
}


