import 'package:attendance/src/authentication/firebase_auth_repository.dart';
import 'package:attendance/src/models/attendance.dart';
import 'package:attendance/src/repositories/attendance_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attendance_service.g.dart';

class AttendanceService {
  AttendanceService(this._attendanceRepository);
  final AttendanceRepository _attendanceRepository;

  Stream<List<Attendance>> allAttendanceByDateStream(String type) =>
      _attendanceRepository.watchAttendances(
          type: type, queryType: QueryType.queryDate);

  Stream<List<Attendance>> allAttendanceByRfidStream(String type) =>
      _attendanceRepository.watchAttendances(
          type: type, queryType: QueryType.queryRfid);
}

@riverpod
AttendanceService attendanceService(AttendanceServiceRef ref, String season) {
  return AttendanceService(ref.watch(attendanceRepositoryProvider(season)));
}

@riverpod
Stream<List<Attendance>> attendanceByDateStream(
    AttendanceByDateStreamRef ref, String season, String type) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching entries');
  }
  final attendanceService = ref.watch(attendanceServiceProvider(season));
  return attendanceService.allAttendanceByDateStream(type);
}

@riverpod
Stream<List<Attendance>> attendanceByRfidStream(
    AttendanceByRfidStreamRef ref, String season, String type) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching entries');
  }
  final attendanceService = ref.watch(attendanceServiceProvider(season));
  return attendanceService.allAttendanceByRfidStream(type);
}
