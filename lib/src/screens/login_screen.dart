import 'package:attendance/src/authentication/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProviders = ref.watch(authProvidersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.attendanceTitle),
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
                ? Text(AppLocalizations.of(context)!.pleaseSignin)
                : Text(AppLocalizations.of(context)!.pleaseSignup),
          );
        },
        footerBuilder: (context, action) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              AppLocalizations.of(context)!.terms,
              style: const TextStyle(color: Colors.grey),
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
