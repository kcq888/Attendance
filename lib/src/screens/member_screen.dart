import 'package:attendant151/src/common_widgets/list_items_builder.dart';
import 'package:attendant151/src/models/member.dart';
import 'package:attendant151/src/services/member_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MemberScreen extends ConsumerWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final memberQueryStream = ref.watch(memberStreamProvider);
          return ListItemsBuilder<Member>(
              data: memberQueryStream,
              itemBuilder: (context, member) => MemberListTile(member: member));
        },
      ),
    );
  }
}

class MemberListTile extends StatelessWidget {
  const MemberListTile({Key? key, required this.member}) : super(key: key);
  final Member member;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${member.firstname} ${member.lastname}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
          children: [const Text('RFID:'), const Spacer(), Text(member.rfid)]),
    );
  }
}
