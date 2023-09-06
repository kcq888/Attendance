import 'package:attendant151/src/models/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'member_repository.g.dart';

class MemberRepository {
  const MemberRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static const String _members = 'Season2023-2024/members/rfids';

  Stream get members => _firestore.collection(_members).snapshots();

  Stream<Member> watchMember({required doc}) => _firestore
      .collection(_members)
      .doc(doc)
      .withConverter<Member>(
          fromFirestore: (snapshot, _) => Member.fromMap(snapshot, snapshot.id),
          toFirestore: (attendant, _) => attendant.toMap())
      .snapshots()
      .map((snapshot) => snapshot.data()!);

  Stream<List<Member>> watchMembers() => queryMembers()
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

  Query<Member> queryMembers() {
    Query<Member> query = _firestore.collection(_members).withConverter<Member>(
        fromFirestore: (snapshot, _) => Member.fromMap(snapshot, snapshot.id),
        toFirestore: (member, _) => member.toMap());

    return query;
  }
}

@Riverpod(keepAlive: true)
MemberRepository memberRepository(MemberRepositoryRef ref) {
  return MemberRepository(FirebaseFirestore.instance);
}
