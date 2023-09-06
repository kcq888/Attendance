import 'package:attendant151/src/common_widgets/list_items_builder.dart';
import 'package:attendant151/src/models/attendant.dart';
import 'package:attendant151/src/screens/custom_profile_screen.dart';
import 'package:attendant151/src/services/attendant_service.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AttendantScreen extends ConsumerWidget {
  const AttendantScreen({super.key});
  final String _date = '09022023';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendant of the Day'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                    builder: (context) => const CustomProfileScreen()),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final attendantByDateQueryStream =
              ref.watch(attendantByDateStreamProvider(_date));
          return ListItemsBuilder<Attendant>(
              data: attendantByDateQueryStream,
              itemBuilder: (context, attendant) =>
                  AttendantListTile(attendant: attendant));
        },
      ),
    );
  }
}

class AttendantListTile extends StatelessWidget {
  const AttendantListTile({Key? key, required this.attendant})
      : super(key: key);
  final Attendant attendant;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          attendant.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Container(
          alignment: Alignment.centerLeft,
          child: Column(children: [
            Row(children: [
              const Text('SignIn:'),
              const Spacer(),
              Text(DateFormat('E dd/MM/yyyy, HH:mm a')
                  .format(attendant.signIn.toDate()))
            ]),
            Row(children: [
              const Text('SignOut:'),
              const Spacer(),
              Text(DateFormat('E dd/MM/yyyy, HH:mm a')
                  .format(attendant.signOut.toDate()))
            ])
          ]),
        ));
  }
}
