import 'package:firebase_auth/firebase_auth.dart'
    hide AuthProvider, EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter_test/flutter_test.dart';
// ignore: depend_on_referenced_packages
import 'package:riverpod/riverpod.dart';

import 'package:attendance/src/authentication/auth_providers.dart';

void main() {
  test('authProviders returns a list of AuthProviders', () {
    final container = ProviderContainer();
    final authProviders = container.read(authProvidersProvider);

    expect(
        authProviders, isA<List<AuthProvider<AuthListener, AuthCredential>>>());
    expect(authProviders.length, 2);
    expect(authProviders[0], isA<EmailAuthProvider>());
    expect(authProviders[1], isA<GoogleProvider>());
  });

  test('GoogleProvider has the correct clientId', () {
    final container = ProviderContainer();
    final authProviders = container.read(authProvidersProvider);

    final googleProvider = authProviders[1] as GoogleProvider;
    expect(googleProvider.clientId,
        '997114318074-9lbg93m8qsuba2lo9k7cqjgkkdjij27t.apps.googleusercontent.com');
  });
}
