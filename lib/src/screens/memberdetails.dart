import 'package:attendance/src/common_widgets/list_items_builder.dart';
import 'package:attendance/src/constants/constants.dart';
import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/repositories/attendance_repository.dart';
import 'package:attendance/src/repositories/attendance_settings.dart';
import 'package:attendance/src/screens/attendance_screen.dart';
import 'package:attendance/src/services/attendance_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberDetailScreen extends ConsumerWidget {
  const MemberDetailScreen({super.key, required this.member});
  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.memberDetailsTitle),
        actions: [
          IconButton(
              onPressed: () => signIn(context, ref),
              icon: const Icon(Icons.login)),
          IconButton(
              onPressed: () => signOut(context, ref),
              icon: const Icon(Icons.logout))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final String? season =
            ref.read(SharedPrefStringNotifier.provider(seasonKey));

        final attendanceByRfidStream =
            ref.watch(attendanceByRfidStreamProvider(season!, member.rfid));
        return ListItemsBuilder(
            data: attendanceByRfidStream,
            itemBuilder: (context, attendance) =>
                AttendanceListTile(attendance: attendance));
      }),
    );
  }

  // sign-in the member
  void signIn(BuildContext context, WidgetRef ref) async {
    final String? season =
        ref.read(SharedPrefStringNotifier.provider(seasonKey));

    final attendanceRepository =
        ref.watch(attendanceRepositoryProvider(season!));
    final bool success = await attendanceRepository.signIn(member);
    String name = '${member.firstname} ${member.lastname}';
    if (success) {
      Future.delayed(Duration.zero).then((value) =>
          showsnackbar(context, AppLocalizations.of(context)!.signin, name));
    } else {
      Future.delayed(Duration.zero).then((value) => showsnackbar(
          context,
          AppLocalizations.of(context)!.signin,
          '$name ${AppLocalizations.of(context)!.already}'));
    }
  }

  // sign-out the member
  void signOut(BuildContext context, WidgetRef ref) async {
    final String? season =
        ref.read(SharedPrefStringNotifier.provider(seasonKey));

    final attendanceRepository =
        ref.watch(attendanceRepositoryProvider(season!));
    bool success = await attendanceRepository.signOut(member);
    String name = '${member.firstname} ${member.lastname}';
    if (success) {
      Future.delayed(Duration.zero).then((value) =>
          showsnackbar(context, AppLocalizations.of(context)!.signout, name));
    } else {
      Future.delayed(Duration.zero).then((value) => showsnackbar(
          context,
          AppLocalizations.of(context)!.signout,
          '$name ${AppLocalizations.of(context)!.already}'));
    }
  }

  void showsnackbar(BuildContext context, String attendanceType, String name) {
    final snackBar = SnackBar(
      backgroundColor: Colors.orange,
      content: Text(
        '$name $attendanceType!',
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
