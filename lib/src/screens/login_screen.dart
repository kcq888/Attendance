import 'package:attendance/src/authentication/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvidersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tough Techs 151 Attendance"),
      ),
      body: SignInScreen(
        providers: authProviders,
        headerBuilder: (context, constraints, shrinkOffset) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('assets/images/151_Logo.png'),
            ),
          );
        },
        subtitleBuilder: (context, action) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: action == AuthAction.signIn
                ? const Text(
                    'Welcome to Tough Techs Attendance, please sign in!')
                : const Text(
                    'Welcome to Tough Techs Attendance, please sign up!'),
          );
        },
        footerBuilder: (context, action) {
          return const Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'By signing in, you agree to our terms and conditions.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
        sideBuilder: (context, shrinkOffset) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset('assets/images/151_Logo.png'),
            ),
          );
        },
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            if (!state.user!.emailVerified) {
              String? signInMsg = state.user!.email;
              SnackBar(content: Text(signInMsg!));
            }
          })
        ],
      ),
    );
  }
}
