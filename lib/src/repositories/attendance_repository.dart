import 'package:attendance/src/authentication/firebase_auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/attendance.dart';

part 'attendance_repository.g.dart';

enum QueryType { queryDate, queryRfid }

class AttendanceRepository {
  const AttendanceRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static const String _season = 'Season2023-2024/meetings/dates';

  // a stream that is continuously listening for changes happening in the database
  Stream get attendances => _firestore.collection(_season).snapshots();

  // Read query repository
  Stream<Attendance> watchAttandance({required doc}) => _firestore
      .collection(_season)
      .doc(doc)
      .withConverter<Attendance>(
          fromFirestore: (snapshot, _) =>
              Attendance.fromMap(snapshot, snapshot.id),
          toFirestore: (attendance, _) => attendance.toMap())
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  Stream<List<Attendance>> watchAttendances(
          {required String type, required QueryType queryType}) =>
      queryAttendances(type: type, queryType: queryType)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Attendance> queryAttendances({required type, required queryType}) {
    String queryFilter =
        (queryType == QueryType.queryDate) ? 'Date' : 'RFIDTag';
    Query<Attendance> query = _firestore
        .collection(_season)
        .orderBy("Name")
        .where(queryFilter, isEqualTo: type)
        .withConverter<Attendance>(
            fromFirestore: (snapsnot, _) =>
                Attendance.fromMap(snapsnot, snapsnot.id),
            toFirestore: (attendance, _) => attendance.toMap());

    return query;
  }
}

@Riverpod(keepAlive: true)
AttendanceRepository attendanceRepository(AttendanceRepositoryRef ref) {
  return AttendanceRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Attendance> attendanceDateQuery(AttendanceDateQueryRef ref, String date) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(attendanceRepositoryProvider);
  return repository.queryAttendances(
      type: date, queryType: QueryType.queryDate);
}

@riverpod
Query<Attendance> attendanceRfidQuery(AttendanceRfidQueryRef ref, String rfid) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(attendanceRepositoryProvider);
  return repository.queryAttendances(
      type: rfid, queryType: QueryType.queryRfid);
}
