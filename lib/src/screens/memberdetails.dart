import 'package:attendance/src/common_widgets/list_items_builder.dart';
import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/screens/attendance_screen.dart';
import 'package:attendance/src/services/attendance_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberDetailScreen extends ConsumerWidget {
  const MemberDetailScreen({super.key, required this.member});
  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Attendance Details'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final attendanceByRfidStream =
            ref.watch(attendanceByRfidStreamProvider(member.rfid));
        return ListItemsBuilder(
            data: attendanceByRfidStream,
            itemBuilder: (context, attendance) =>
                AttendanceListTile(attendance: attendance));
      }),
    );
  }
}
