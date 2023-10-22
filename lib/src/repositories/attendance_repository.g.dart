// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendanceRepositoryHash() =>
    r'028e73986e27e9041dd40b9d25126d4f8fbaeb15';

/// See also [attendanceRepository].
@ProviderFor(attendanceRepository)
final attendanceRepositoryProvider = Provider<AttendanceRepository>.internal(
  attendanceRepository,
  name: r'attendanceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$attendanceRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AttendanceRepositoryRef = ProviderRef<AttendanceRepository>;
String _$attendanceDateQueryHash() =>
    r'ef5243da825bff19a4edc42196d2d4742f97c0a8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef AttendanceDateQueryRef = AutoDisposeProviderRef<Query<Attendance>>;

/// See also [attendanceDateQuery].
@ProviderFor(attendanceDateQuery)
const attendanceDateQueryProvider = AttendanceDateQueryFamily();

/// See also [attendanceDateQuery].
class AttendanceDateQueryFamily extends Family<Query<Attendance>> {
  /// See also [attendanceDateQuery].
  const AttendanceDateQueryFamily();

  /// See also [attendanceDateQuery].
  AttendanceDateQueryProvider call(
    String date,
  ) {
    return AttendanceDateQueryProvider(
      date,
    );
  }

  @override
  AttendanceDateQueryProvider getProviderOverride(
    covariant AttendanceDateQueryProvider provider,
  ) {
    return call(
      provider.date,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attendanceDateQueryProvider';
}

/// See also [attendanceDateQuery].
class AttendanceDateQueryProvider
    extends AutoDisposeProvider<Query<Attendance>> {
  /// See also [attendanceDateQuery].
  AttendanceDateQueryProvider(
    this.date,
  ) : super.internal(
          (ref) => attendanceDateQuery(
            ref,
            date,
          ),
          from: attendanceDateQueryProvider,
          name: r'attendanceDateQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendanceDateQueryHash,
          dependencies: AttendanceDateQueryFamily._dependencies,
          allTransitiveDependencies:
              AttendanceDateQueryFamily._allTransitiveDependencies,
        );

  final String date;

  @override
  bool operator ==(Object other) {
    return other is AttendanceDateQueryProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$attendanceRfidQueryHash() =>
    r'4fec1b91f55da1c82b1155914bc61c74e7ab9e36';
typedef AttendanceRfidQueryRef = AutoDisposeProviderRef<Query<Attendance>>;

/// See also [attendanceRfidQuery].
@ProviderFor(attendanceRfidQuery)
const attendanceRfidQueryProvider = AttendanceRfidQueryFamily();

/// See also [attendanceRfidQuery].
class AttendanceRfidQueryFamily extends Family<Query<Attendance>> {
  /// See also [attendanceRfidQuery].
  const AttendanceRfidQueryFamily();

  /// See also [attendanceRfidQuery].
  AttendanceRfidQueryProvider call(
    String rfid,
  ) {
    return AttendanceRfidQueryProvider(
      rfid,
    );
  }

  @override
  AttendanceRfidQueryProvider getProviderOverride(
    covariant AttendanceRfidQueryProvider provider,
  ) {
    return call(
      provider.rfid,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'attendanceRfidQueryProvider';
}

/// See also [attendanceRfidQuery].
class AttendanceRfidQueryProvider
    extends AutoDisposeProvider<Query<Attendance>> {
  /// See also [attendanceRfidQuery].
  AttendanceRfidQueryProvider(
    this.rfid,
  ) : super.internal(
          (ref) => attendanceRfidQuery(
            ref,
            rfid,
          ),
          from: attendanceRfidQueryProvider,
          name: r'attendanceRfidQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendanceRfidQueryHash,
          dependencies: AttendanceRfidQueryFamily._dependencies,
          allTransitiveDependencies:
              AttendanceRfidQueryFamily._allTransitiveDependencies,
        );

  final String rfid;

  @override
  bool operator ==(Object other) {
    return other is AttendanceRfidQueryProvider && other.rfid == rfid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, rfid.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
