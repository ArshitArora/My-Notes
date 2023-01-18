import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../lib/enums/menu_actions.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  String? get loginRoute => null;

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
                    loginRoute!,
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