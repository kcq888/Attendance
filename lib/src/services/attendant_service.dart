import 'package:attendant151/src/authentication/firebase_auth_repository.dart';
import 'package:attendant151/src/models/attendant.dart';
import 'package:attendant151/src/repositories/attendant_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'attendant_service.g.dart';

class AttendantService {
  AttendantService(this._attendantRepository);
  final AttendantRepository _attendantRepository;

  Stream<List<Attendant>> allAttendantByDateStream(String type) =>
      _attendantRepository.watchAttendants(
          type: type, queryType: QueryType.queryDate);

  Stream<List<Attendant>> allAttendantByRfidStream(String type) =>
      _attendantRepository.watchAttendants(
          type: type, queryType: QueryType.queryRfid);
}

@riverpod
AttendantService attendantService(AttendantServiceRef ref) {
  return AttendantService(ref.watch(attendantRepositoryProvider));
}

@riverpod
Stream<List<Attendant>> attendantByDateStream(
    AttendantByDateStreamRef ref, String type) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching entries');
  }
  final attendantService = ref.watch(attendantServiceProvider);
  return attendantService.allAttendantByDateStream(type);
}

@riverpod
Stream<List<Attendant>> attendantByRfidStream(
    AttendantByRfidStreamRef ref, String type) {
  final user = ref.watch(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('User can\'t be null when fetching entries');
  }
  final attendantService = ref.watch(attendantServiceProvider);
  return attendantService.allAttendantByRfidStream(type);
}
