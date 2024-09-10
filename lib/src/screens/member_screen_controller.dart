import 'package:attendance/src/authentication/firebase_auth_repository.dart';
import 'package:attendance/src/constants/constants.dart';
import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/repositories/attendance_settings.dart';
import 'package:attendance/src/repositories/member_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_screen_controller.g.dart';

@riverpod
class MemberScreenController extends _$MemberScreenController {
  @override
  FutureOr<void> build() {
    // ok to leave this empty if the return type is FutureOr<void>
  }

  checkLogin() {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
  }

  Future<void> deleteMember(Member member) async {
    checkLogin();
    final String? season =
        ref.read(SharedPrefStringNotifier.provider(seasonKey));

    final repository = ref.read(memberRepositoryProvider(season!));
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => repository.deleteMember(rfid: member.rfid));
  }

  Future<void> updateMember(Member member) async {
    checkLogin();
    final String? season =
        ref.read(SharedPrefStringNotifier.provider(seasonKey));

    final repository = ref.read(memberRepositoryProvider(season!));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.updateMember(
        firstname: member.firstname,
        lastname: member.lastname,
        rfid: member.rfid));
  }

  Future<void> addMember(Member member) async {
    checkLogin();
    final String? season =
        ref.read(SharedPrefStringNotifier.provider(seasonKey));

    final repository = ref.read(memberRepositoryProvider(season!));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repository.addMember(
        firstname: member.firstname,
        lastname: member.lastname,
        rfid: member.rfid));
  }
}
