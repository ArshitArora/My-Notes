
import 'package:flutter/material.dart';
import 'package:privatenotes/constants/routes.dart';
import 'package:privatenotes/service/auth/auth_service.dart';


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
          TextButton(onPressed: ()async {
            await AuthService.firebase().sendEmailVerification();
          }, child: (
            const Text('Send Email Verification')
          )
          ),
          TextButton(
            onPressed: ()async {
              await AuthService.firebase().logout();
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