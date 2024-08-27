import 'package:attendance/src/authentication/firebase_auth_repository.dart';
import 'package:attendance/src/models/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/attendance.dart';

part 'attendance_repository.g.dart';

enum QueryType { queryDate, queryRfid }

class AttendanceRepository {
  const AttendanceRepository(this._firestore, this._season);
  final FirebaseFirestore _firestore;
  final String _season;

  static const String _datesCol = '/meetings/dates';

  // a stream that is continuously listening for changes happening in the database
  Stream get attendances =>
      _firestore.collection(_season + _datesCol).snapshots();

  // Read query repository
  Stream<Attendance> watchAttandance({required doc}) => _firestore
      .collection(_season + _datesCol)
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
        .collection(_season + _datesCol)
        .orderBy("Name")
        .where(queryFilter, isEqualTo: type)
        .withConverter<Attendance>(
            fromFirestore: (snapsnot, _) =>
                Attendance.fromMap(snapsnot, snapsnot.id),
            toFirestore: (attendance, _) => attendance.toMap());

    return query;
  }

  Future<bool> signIn(Member member) async {
    String date = DateFormat('MMddyyyy').format(DateTime.now());
    String docId = '${member.rfid}_$date';
    Map<String, dynamic> sigInData = {
      'Date': date,
      'HasSignOut': false,
      'Name': '${member.firstname} ${member.lastname}',
      'RFIDTag': member.rfid,
      'SignIn': DateTime.now().toUtc()
    };
    try {
      // check if the docs already exist, if it does, return false
      bool docExist = await doesDocExist(docId);
      if (!docExist) {
        _firestore
            .collection(_season + _datesCol)
            .doc(docId)
            .set(sigInData)
            .onError((error, stackTrace) => throw FirebaseException(
                plugin: docId,
                message:
                    'Error member sign in for ${member.firstname} ${member.lastname}'));
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return false;
    }
    return true;
  }

  Future<bool> signOut(Member member) async {
    String date = DateFormat('MMddyyyy').format(DateTime.now());
    String docId = '${member.rfid}_$date';
    Map<String, dynamic> sigInData = {
      'HasSignOut': true,
      'SignOut': DateTime.now().toUtc()
    };
    try {
      bool hasSignout = await alreadySignOut(docId);
      if (!hasSignout) {
        _firestore
            .collection(_season + _datesCol)
            .doc(docId)
            .update(sigInData)
            .onError((error, stackTrace) => throw FirebaseException(
                plugin: docId,
                message:
                    'Error member sign out for ${member.firstname} ${member.lastname}'));
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return false;
    }
    return true;
  }

  Future<bool> doesDocExist(String docId) async {
    try {
      var doc =
          await _firestore.collection(_season + _datesCol).doc(docId).get();
      return doc.exists;
    } catch (error) {
      rethrow;
    }
  }

  Future<bool> alreadySignOut(String docId) async {
    try {
      var doc =
          await _firestore.collection(_season + _datesCol).doc(docId).get();
      Map<String, dynamic> data = doc.data()!;
      if (data['HasSignOut']) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }
}

@Riverpod(keepAlive: true)
AttendanceRepository attendanceRepository(
    AttendanceRepositoryRef ref, String season) {
  return AttendanceRepository(FirebaseFirestore.instance, season);
}

// @riverpod
// Query<Attendance> attendanceDateQuery(AttendanceDateQueryRef ref, String date) {
//   final user = ref.watch(authRepositoryProvider).currentUser;
//   if (user == null) {
//     throw AssertionError('User can\'t be null');
//   }
//   final repository = ref.watch(attendanceRepositoryProvider('Season2023-2024'));
//   return repository.queryAttendances(
//       type: date, queryType: QueryType.queryDate);
// }

// @riverpod
// Query<Attendance> attendanceRfidQuery(AttendanceRfidQueryRef ref, String rfid) {
//   final user = ref.watch(authRepositoryProvider).currentUser;
//   if (user == null) {
//     throw AssertionError('User can\'t be null');
//   }
//   final repository = ref.watch(attendanceRepositoryProvider('Season2023-2024'));
//   return repository.queryAttendances(
//       type: rfid, queryType: QueryType.queryRfid);
// }
