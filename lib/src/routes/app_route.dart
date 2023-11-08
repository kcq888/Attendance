import 'package:attendance/src/authentication/firebase_auth_repository.dart';
import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/routes/go_router_refresh_stream.dart';
import 'package:attendance/src/routes/scaffold_with_nested_navigation.dart';
import 'package:attendance/src/screens/attendance_screen.dart';
import 'package:attendance/src/screens/custom_profile_screen.dart';
import 'package:attendance/src/screens/edit_member.dart';
import 'package:attendance/src/screens/login_screen.dart';
import 'package:attendance/src/screens/member_screen.dart';
import 'package:attendance/src/screens/memberdetails.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_route.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _attendancesNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'attendances');
final _membersNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'members');
final _accountNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'account');

enum AppRoute {
  signin,
  attendances,
  newdate,
  members,
  memberdetail,
  addmember,
  editmember,
  profile,
  signIn,
  signOut
}

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
            return '/attendances';
          }
        } else {
          if (state.uri.path.startsWith('/attendances') ||
              state.uri.path.startsWith('/members') ||
              state.uri.path.startsWith('/memberdetail') ||
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
              navigatorKey: _attendancesNavigatorKey,
              routes: [
                GoRoute(
                  path: '/attendances',
                  name: AppRoute.attendances.name,
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: AttendanceScreen(),
                  ),
                )
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _membersNavigatorKey,
              routes: [
                GoRoute(
                    path: '/members',
                    name: AppRoute.members.name,
                    pageBuilder: (context, state) => const NoTransitionPage(
                          child: MemberScreen(),
                        ),
                    routes: [
                      GoRoute(
                          path: 'add',
                          name: AppRoute.addmember.name,
                          parentNavigatorKey: _rootNavigatorKey,
                          pageBuilder: (context, state) {
                            return const MaterialPage(
                                fullscreenDialog: true,
                                child: EditMemberScreen());
                          }),
                      GoRoute(
                        path: 'edit',
                        name: AppRoute.editmember.name,
                        pageBuilder: (context, state) {
                          final member = state.extra as Member;
                          return MaterialPage(
                              child: EditMemberScreen(member: member));
                        },
                      ),
                      GoRoute(
                          path: 'detail',
                          name: AppRoute.memberdetail.name,
                          pageBuilder: (context, state) => NoTransitionPage(
                                child: MemberDetailScreen(
                                    member: state.extra! as Member),
                              ))
                    ]),
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
