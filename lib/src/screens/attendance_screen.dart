import 'package:attendance/src/common_widgets/list_items_builder.dart';
import 'package:attendance/src/models/attendance.dart';
import 'package:attendance/src/repositories/attendance_datepicker.dart';
import 'package:attendance/src/services/attendance_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

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
        title: Text(AppLocalizations.of(context)!.attendanceOfTheDay),
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
              attendanceByDateStreamProvider(DateFormat('MMddyyyy')
                  .format(ref.watch(selectedDateProvider))));
          return ListItemsBuilder<Attendance>(
              data: attendantByDateQueryStream,
              itemBuilder: (context, attendance) =>
                  AttendanceListTile(attendance: attendance));
        },
      ),
    );
  }
}

class AttendanceListTile extends StatelessWidget {
  const AttendanceListTile({Key? key, required this.attendance})
      : super(key: key);
  final Attendance attendance;
  final String _signIn = 'SignIn';
  final String _signOut = 'SignOut';
  final String _dateFormat = 'E MM/dd/yyyy, HH:mm a';

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          attendance.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Container(
          alignment: Alignment.centerLeft,
          child: Column(children: [
            Row(
                children: buildTileRowWidgets(
                    context, attendance, AppLocalizations.of(context)!.signin)),
            Row(
              children: buildTileRowWidgets(
                  context, attendance, AppLocalizations.of(context)!.signout),
            )
          ]),
        ));
  }

  List<Widget> buildTileRowWidgets(
      BuildContext context, Attendance attendance, String type) {
    var tileRowWidgets = [Text(type), const Spacer()];

    if (type == _signIn) {
      tileRowWidgets.add(
          Text(DateFormat(_dateFormat).format(attendance.signIn.toDate())));
    } else if (type == _signOut) {
      if (attendance.hasSignOut) {
        tileRowWidgets.add(
            Text(DateFormat(_dateFormat).format(attendance.signOut.toDate())));
      } else {
        tileRowWidgets.add(Text(AppLocalizations.of(context)!.hasnotsignout));
      }
    }

    return tileRowWidgets;
  }
}
