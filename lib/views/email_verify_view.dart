

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:privatenotes/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification')
      ),
      
      body: Column(children: [
          const Text("We've already sent you an email verification, please open to verify your account"),
          const Text("If you haven't yet received an email, please click on the button below"),
          TextButton(onPressed: (){
            final user = FirebaseAuth.instance.currentUser;
            user?.sendEmailVerification();
          }, child: (
            const Text('Send Email Verification')
          )
          ),
          TextButton(
            onPressed: ()async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                 (route) => false);
          }, 
          child: const Text('Restart'))
        ]
        ),
    );
    
  }
}