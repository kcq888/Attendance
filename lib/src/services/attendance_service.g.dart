// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendanceServiceHash() => r'72d40bd9132416e005534969849b46033c3926b3';

/// See also [attendanceService].
@ProviderFor(attendanceService)
final attendanceServiceProvider =
    AutoDisposeProvider<AttendanceService>.internal(
  attendanceService,
  name: r'attendanceServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$attendanceServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AttendanceServiceRef = AutoDisposeProviderRef<AttendanceService>;
String _$attendanceByDateStreamHash() =>
    r'967a3d21c62afb5b215824e0c4c949e1e0e4af3d';

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

typedef AttendanceByDateStreamRef
    = AutoDisposeStreamProviderRef<List<Attendance>>;

/// See also [attendanceByDateStream].
@ProviderFor(attendanceByDateStream)
const attendanceByDateStreamProvider = AttendanceByDateStreamFamily();

/// See also [attendanceByDateStream].
class AttendanceByDateStreamFamily
    extends Family<AsyncValue<List<Attendance>>> {
  /// See also [attendanceByDateStream].
  const AttendanceByDateStreamFamily();

  /// See also [attendanceByDateStream].
  AttendanceByDateStreamProvider call(
    String type,
  ) {
    return AttendanceByDateStreamProvider(
      type,
    );
  }

  @override
  AttendanceByDateStreamProvider getProviderOverride(
    covariant AttendanceByDateStreamProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'attendanceByDateStreamProvider';
}

/// See also [attendanceByDateStream].
class AttendanceByDateStreamProvider
    extends AutoDisposeStreamProvider<List<Attendance>> {
  /// See also [attendanceByDateStream].
  AttendanceByDateStreamProvider(
    this.type,
  ) : super.internal(
          (ref) => attendanceByDateStream(
            ref,
            type,
          ),
          from: attendanceByDateStreamProvider,
          name: r'attendanceByDateStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendanceByDateStreamHash,
          dependencies: AttendanceByDateStreamFamily._dependencies,
          allTransitiveDependencies:
              AttendanceByDateStreamFamily._allTransitiveDependencies,
        );

  final String type;

  @override
  bool operator ==(Object other) {
    return other is AttendanceByDateStreamProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$attendanceByRfidStreamHash() =>
    r'9bbfdc45be0dafd7aa5e546efc826d50255dbc46';
typedef AttendanceByRfidStreamRef
    = AutoDisposeStreamProviderRef<List<Attendance>>;

/// See also [attendanceByRfidStream].
@ProviderFor(attendanceByRfidStream)
const attendanceByRfidStreamProvider = AttendanceByRfidStreamFamily();

/// See also [attendanceByRfidStream].
class AttendanceByRfidStreamFamily
    extends Family<AsyncValue<List<Attendance>>> {
  /// See also [attendanceByRfidStream].
  const AttendanceByRfidStreamFamily();

  /// See also [attendanceByRfidStream].
  AttendanceByRfidStreamProvider call(
    String type,
  ) {
    return AttendanceByRfidStreamProvider(
      type,
    );
  }

  @override
  AttendanceByRfidStreamProvider getProviderOverride(
    covariant AttendanceByRfidStreamProvider provider,
  ) {
    return call(
      provider.type,
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
  String? get name => r'attendanceByRfidStreamProvider';
}

/// See also [attendanceByRfidStream].
class AttendanceByRfidStreamProvider
    extends AutoDisposeStreamProvider<List<Attendance>> {
  /// See also [attendanceByRfidStream].
  AttendanceByRfidStreamProvider(
    this.type,
  ) : super.internal(
          (ref) => attendanceByRfidStream(
            ref,
            type,
          ),
          from: attendanceByRfidStreamProvider,
          name: r'attendanceByRfidStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendanceByRfidStreamHash,
          dependencies: AttendanceByRfidStreamFamily._dependencies,
          allTransitiveDependencies:
              AttendanceByRfidStreamFamily._allTransitiveDependencies,
        );

  final String type;

  @override
  bool operator ==(Object other) {
    return other is AttendanceByRfidStreamProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
