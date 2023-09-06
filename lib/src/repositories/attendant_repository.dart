import 'package:attendant151/src/authentication/firebase_auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/attendant.dart';

part 'attendant_repository.g.dart';

enum QueryType { queryDate, queryRfid }

class AttendantRepository {
  const AttendantRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static const String _season = 'Season2023-2024/meetings/dates';

  // a stream that is continuously listening for changes happening in the database
  Stream get attendants => _firestore.collection(_season).snapshots();

  // Read query repository
  Stream<Attendant> watchAttandant({required doc}) => _firestore
      .collection(_season)
      .doc(doc)
      .withConverter<Attendant>(
          fromFirestore: (snapshot, _) =>
              Attendant.fromMap(snapshot, snapshot.id),
          toFirestore: (attendant, _) => attendant.toMap())
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  Stream<List<Attendant>> watchAttendants(
          {required String type, required QueryType queryType}) =>
      queryAttendants(type: type, queryType: queryType)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Attendant> queryAttendants({required type, required queryType}) {
    String queryFilter =
        (queryType == QueryType.queryDate) ? 'Date' : 'RFIDTag';
    Query<Attendant> query = _firestore
        .collection(_season)
        .where(queryFilter, isEqualTo: type)
        .withConverter<Attendant>(
            fromFirestore: (snapsnot, _) =>
                Attendant.fromMap(snapsnot, snapsnot.id),
            toFirestore: (attendant, _) => attendant.toMap());

    return query;
  }
}

@Riverpod(keepAlive: true)
AttendantRepository attendantRepository(AttendantRepositoryRef ref) {
  return AttendantRepository(FirebaseFirestore.instance);
}

@riverpod
Query<Attendant> attendantDateQuery(AttendantDateQueryRef ref, String date) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(attendantRepositoryProvider);
  return repository.queryAttendants(type: date, queryType: QueryType.queryDate);
}

@riverpod
Query<Attendant> attendantRfidQuery(AttendantRfidQueryRef ref, String rfid) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null');
  }
  final repository = ref.watch(attendantRepositoryProvider);
  return repository.queryAttendants(type: rfid, queryType: QueryType.queryRfid);
}
