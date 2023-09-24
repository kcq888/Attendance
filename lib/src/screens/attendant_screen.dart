import 'package:attendant151/src/common_widgets/list_items_builder.dart';
import 'package:attendant151/src/models/attendant.dart';
import 'package:attendant151/src/repositories/attendant_datepicker.dart';
import 'package:attendant151/src/services/attendant_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AttendantScreen extends ConsumerWidget {
  const AttendantScreen({super.key});

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null) {
      ref.read(selectedDateProvider.notifier).state = pickedDate;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendant of the Day'),
        actions: [
          IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () => _selectDate(context, ref))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final attendantByDateQueryStream = ref.watch(
              attendantByDateStreamProvider(DateFormat('MMddyyyy')
                  .format(ref.watch(selectedDateProvider))));
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
  final String _signIn = 'SignIn';
  final String _signOut = 'SignOut';
  final String _dateFormat = 'E MM/dd/yyyy, HH:mm a';

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
            Row(children: buildTileRowWidgets(attendant, _signIn)),
            Row(
              children: buildTileRowWidgets(attendant, _signOut),
            )
          ]),
        ));
  }

  List<Widget> buildTileRowWidgets(Attendant attendant, String type) {
    var tileRowWidgets = [Text(type), const Spacer()];

    if (type == _signIn) {
      tileRowWidgets
          .add(Text(DateFormat(_dateFormat).format(attendant.signIn.toDate())));
    } else if (type == _signOut) {
      if (attendant.hasSignOut) {
        tileRowWidgets.add(
            Text(DateFormat(_dateFormat).format(attendant.signOut.toDate())));
      } else {
        tileRowWidgets.add(const Text('Has not been signout'));
      }
    }

    return tileRowWidgets;
  }
}
