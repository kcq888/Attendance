import 'package:attendant151/src/authentication/firebase_auth_repository.dart';
import 'package:attendant151/src/routes/go_router_refresh_stream.dart';
import 'package:attendant151/src/routes/scaffold_with_nested_navigation.dart';
import 'package:attendant151/src/screens/custom_profile_screen.dart';
import 'package:attendant151/src/screens/attendant_screen.dart';
import 'package:attendant151/src/screens/login_screen.dart';
import 'package:attendant151/src/screens/member_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_route.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _attendantsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'attendants');
final _membersNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'members');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute { signin, attendants, members, addmember, editmember, profile }

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(
      initialLocation: '/signIn',
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      redirect: (context, state) {
        final isLoggedIn = authRepository.currentUser != null;
        if (isLoggedIn) {
          if (state.uri.path.startsWith('/signIn')) {
            return '/attendants';
          }
        } else {
          if (state.uri.path.startsWith('/attendants') ||
              state.uri.path.startsWith('/members') ||
              state.uri.path.startsWith('/account')) {
            return '/signIn';
          }
        }
        return null;
      },
      refreshListenable:
          GoRouterRefreshStream(authRepository.authStateChanges()),
      routes: [
        GoRoute(
            path: '/signIn',
            name: AppRoute.signin.name,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: LoginScreen())),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return ScaffoldWithNestedNavigation(
                navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _membersNavigatorKey,
              routes: [
                GoRoute(
                  path: '/attendants',
                  name: AppRoute.members.name,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: AttendantScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _attendantsNavigatorKey,
              routes: [
                GoRoute(
                  path: '/members',
                  name: AppRoute.attendants.name,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: MemberScreen(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _accountNavigatorKey,
              routes: [
                GoRoute(
                  path: '/account',
                  name: AppRoute.profile.name,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: CustomProfileScreen(),
                  ),
                ),
              ],
            ),
          ],
        )
      ]);
}
