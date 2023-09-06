import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Attendant extends Equatable {
  final String name;
  final String rfIdTag;
  final String date;
  final Timestamp signIn;
  final Timestamp signOut;
  final bool hasSignOut;

  const Attendant(this.name, this.rfIdTag, this.date, this.signIn, this.signOut,
      this.hasSignOut);

  @override
  List<Object> get props => [name, rfIdTag, date, signIn, signOut, hasSignOut];

  @override
  bool get stringify => true;

  factory Attendant.fromMap(
      DocumentSnapshot<Map<String, dynamic>> snapshot, String rfid) {
    Map<String, dynamic> data = snapshot.data()!;
    final name = data['Name'] as String;
    final rfid = data['RFIDTag'] as String;
    final date = data['Date'] as String;
    final signin = data['SignIn'] as Timestamp;
    final signout = data['SignOut'] as Timestamp;
    final hassignout = data['HasSignOut'] as bool;

    return Attendant(name, rfid, date, signin, signout, hassignout);
  }

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'RFIDTag': rfIdTag,
      'Date': date,
      'SignIn': signIn,
      'SignOut': signOut,
      'HasSignOut': hasSignOut
    };
  }
}
