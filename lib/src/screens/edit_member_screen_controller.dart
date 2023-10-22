import 'package:attendance/src/authentication/firebase_auth_repository.dart';
import 'package:attendance/src/models/member.dart';
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

    // set loading state
    state = const AsyncLoading().copyWithPrevious(state);
    final repository = ref.read(memberRepositoryProvider);
    if (member != null) {
      state = await AsyncValue.guard(() => repository.updateMember(
          firstname: member.firstname,
          lastname: member.lastname,
          rfid: member.rfid));
    } else {
      state = await AsyncValue.guard(() => repository.addMember(
          firstname: firstname, lastname: lastname, rfid: rfid));
    }

    return state.hasError == false;
  }
}
