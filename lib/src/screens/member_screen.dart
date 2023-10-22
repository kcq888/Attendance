import 'package:attendance/src/common_widgets/empty_content.dart';
import 'package:attendance/src/common_widgets/slide_memu.dart';
import 'package:attendance/src/models/member.dart';
import 'package:attendance/src/routes/app_route.dart';
import 'package:attendance/src/screens/member_screen_controller.dart';
import 'package:attendance/src/services/member_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MemberScreen extends ConsumerWidget {
  const MemberScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(AppRoute.addmember.name),
            icon: const Icon(Icons.add),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final memberQueryStream = ref.watch(memberStreamProvider);
          return memberQueryStream.when(
              data: (items) => ListView.separated(
                  itemCount: items.length + 2,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0.5),
                  itemBuilder: (context, index) {
                    if (index == 0 || index == items.length + 1) {
                      return const SizedBox.shrink();
                    }
                    return MemberListTile(member: items[index - 1]);
                  }),
              error: (_, __) => const EmptyContent(
                    title: 'Something went wrong',
                    message: 'Can\'t load items right now',
                  ),
              loading: () => const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class MemberListTile extends ConsumerWidget {
  const MemberListTile({Key? key, required this.member}) : super(key: key);
  final Member member;

  Future<void> _deleteMember(WidgetRef ref) async {
    await ref
        .read(memberScreenControllerProvider.notifier)
        .deleteMember(member);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SlideMenu(
        menuItems: <Widget>[
          Container(
            color: Colors.black12,
            child: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () =>
                    context.goNamed(AppRoute.editmember.name, extra: member)),
          ),
          Container(
            color: Colors.red,
            child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.delete),
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return buildAlertDialog(context);
                    }).then((value) => _deleteMember(ref))),
          )
        ],
        child: ListTile(
          title: Text(
            '${member.firstname} ${member.lastname}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(children: [
            const Text('RFID:'),
            const Spacer(),
            Text(member.rfid)
          ]),
          onTap: () =>
              context.goNamed(AppRoute.memberdetail.name, extra: member),
        ));
  }
}

Widget buildAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(false));
  Widget continueButton = TextButton(
      child: const Text("OK"),
      onPressed: () => Navigator.of(context, rootNavigator: true).pop(true));
  // set up the AlertDialog
  return AlertDialog(
    title: const Text("Delete Member"),
    content: const Text("Are you sure that you want to delete?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
}
