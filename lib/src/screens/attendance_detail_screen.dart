import 'package:attendance/src/common_widgets/empty_content.dart';
import 'package:attendance/src/constants/constants.dart';
import 'package:attendance/src/models/attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AttendanceDeailScreen extends ConsumerWidget {
  const AttendanceDeailScreen({super.key, required this.attendance});
  final Attendance attendance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.attendanceDetailTitle),
      ),
      body: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return attendance.signInHistory.isNotEmpty
            ? ListView.separated(
                itemCount: attendance.signInHistory.length,
                itemBuilder: (BuildContext context, int index) {
                  String key = (index + 1).toString();
                  return ListTile(
                    title: Text(
                      '${AppLocalizations.of(context)!.attendanceOccurrenceTitle} $key',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                              buildSignInHistory(attendance.signInHistory[key]),
                        )),
                  );
                },
                separatorBuilder: (context, index) =>
                    const Divider(height: 0.5),
              )
            : EmptyContent(
                title: AppLocalizations.of(context)!.nothingHereTitle,
                message: AppLocalizations.of(context)!.nothingHereMessage);
      }),
    );
  }

  buildSignInHistory(Map signInHisotry) {
    List<Widget> signInHistoryWidgets = [];
    signInHisotry.forEach((key, val) {
      signInHistoryWidgets.add(Row(
        children: [
          Text(key.toString()),
          const Spacer(),
          Text(DateFormat(dateTimeFormat).format(val.toDate())),
        ],
      ));
    });
    return signInHistoryWidgets;
  }
}
