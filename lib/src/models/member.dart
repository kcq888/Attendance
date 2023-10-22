import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Member extends Equatable {
  final String firstname;
  final String lastname;
  final String rfid;

  const Member(this.firstname, this.lastname, this.rfid);

  @override
  List<Object> get props => [firstname, lastname, rfid];

  @override
  bool get stringify => true;

  factory Member.fromMap(
      DocumentSnapshot<Map<String, dynamic>> snapshot, String rfid) {
    Map<String, dynamic> data = snapshot.data()!;
    final firstname = data['First'] as String;
    final lastname = data['Last'] as String;
    final rfid = data['RFIDTag'] as String;

    return Member(firstname, lastname, rfid);
  }

  Map<String, dynamic> toMap() {
    return {'First': firstname, 'Last': lastname, 'RFIDTag': rfid};
  }
}
