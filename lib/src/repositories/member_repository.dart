import 'package:attendance/src/models/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_repository.g.dart';

class MemberRepository {
  const MemberRepository(this._firestore, this._season);
  final FirebaseFirestore _firestore;
  final String _season;

  static const String _members = '/members/rfids';

  // Add member
  Future<void> addMember(
      {required firstname, required lastname, required rfid}) async {
    _firestore
        .collection(_season + _members)
        .doc(rfid)
        .set({'First': firstname, 'Last': lastname, 'RFIDTag': rfid}).onError(
            (error, stackTrace) => debugPrint('Add Member: $error'));
  }

  // Update member
  Future<void> updateMember(
      {required firstname, required lastname, required rfid}) async {
    _firestore.collection(_season + _members).doc(rfid).update({
      'First': firstname,
      'Last': lastname,
      'RFIDTag': rfid
    }).onError((error, stackTrace) => debugPrint('Update Member: $error'));
  }

  // Delete member
  Future<void> deleteMember({required rfid}) async {
    _firestore
        .collection(_season + _members)
        .doc(rfid)
        .delete()
        .onError((error, stackTrace) => debugPrint('Delete Member: $error'));
  }

  Stream get members => _firestore.collection(_members).snapshots();

  Stream<Member> watchMember({required doc}) => _firestore
      .collection(_season + _members)
      .doc(doc)
      .withConverter<Member>(
          fromFirestore: (snapshot, _) => Member.fromMap(snapshot, snapshot.id),
          toFirestore: (attendance, _) => attendance.toMap())
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  Stream<List<Member>> watchMembers() => queryMembers()
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Member> queryMembers() {
    Query<Member> query = _firestore
        .collection(_season + _members)
        .orderBy("First")
        .withConverter<Member>(
            fromFirestore: (snapshot, _) =>
                Member.fromMap(snapshot, snapshot.id),
            toFirestore: (member, _) => member.toMap());

    return query;
  }
}

@Riverpod(keepAlive: true)
MemberRepository memberRepository(MemberRepositoryRef ref, String season) {
  return MemberRepository(FirebaseFirestore.instance, season);
}
