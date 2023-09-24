import 'package:attendant151/src/common_widgets/list_items_builder.dart';
import 'package:attendant151/src/models/member.dart';
import 'package:attendant151/src/screens/attendant_screen.dart';
import 'package:attendant151/src/services/attendant_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberDetailScreen extends ConsumerWidget {
  const MemberDetailScreen({super.key, required this.member});
  final Member member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Attendant Details'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final attendantByRfidStream =
            ref.watch(attendantByRfidStreamProvider(member.rfid));
        return ListItemsBuilder(
            data: attendantByRfidStream,
            itemBuilder: (context, attendant) =>
                AttendantListTile(attendant: attendant));
      }),
    );
  }
}
