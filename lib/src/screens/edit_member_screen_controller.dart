import 'package:attendance/src/authentication/firebase_auth_repository.dart';
import 'package:attendance/src/constants/constants.dart';
import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/repositories/attendance_settings.dart';
import 'package:attendance/src/repositories/member_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'edit_member_screen_controller.g.dart';

@riverpod
class EditMemberScreenController extends _$EditMemberScreenController {
  @override
  FutureOr<void> build() {
    //
  }

  checkLogin() {
    final currentUser = ref.read(authRepositoryProvider).currentUser;
    if (currentUser == null) {
      throw AssertionError('User can\'t be null');
    }
  }

  Future<bool> submit(Member? member,
      {required firstname, required lastname, required rfid}) async {
    checkLogin();

    final String? season =
        ref.read(SharedPrefStringNotifier.provider(SEASON_KEY));

    // set loading state
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(memberRepositoryProvider(season!));
    if (member != null) {
      state = await AsyncValue.guard(() => repository.updateMember(
          firstname: firstname, lastname: lastname, rfid: rfid));
    } else {
      state = await AsyncValue.guard(() => repository.addMember(
          firstname: firstname, lastname: lastname, rfid: rfid));
    }

    return state.hasError == false;
  }
}
