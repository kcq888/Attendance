import 'package:firebase_auth/firebase_auth.dart'
    hide AuthProvider, EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
List<AuthProvider<AuthListener, AuthCredential>> authProviders(
    AuthProvidersRef ref) {
  return [
    EmailAuthProvider(),
    GoogleProvider(
        clientId:
            '997114318074-9lbg93m8qsuba2lo9k7cqjgkkdjij27t.apps.googleusercontent.com')
  ];
}
