// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendant_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendantRepositoryHash() =>
    r'fcf234918f755b4a20902c4fd15d588f28945753';

/// See also [attendantRepository].
@ProviderFor(attendantRepository)
final attendantRepositoryProvider = Provider<AttendantRepository>.internal(
  attendantRepository,
  name: r'attendantRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$attendantRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AttendantRepositoryRef = ProviderRef<AttendantRepository>;
String _$attendantDateQueryHash() =>
    r'cb70efd954ca9b3aba5bbc46d68d4d9732279951';

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

typedef AttendantDateQueryRef = AutoDisposeProviderRef<Query<Attendant>>;

/// See also [attendantDateQuery].
@ProviderFor(attendantDateQuery)
const attendantDateQueryProvider = AttendantDateQueryFamily();

/// See also [attendantDateQuery].
class AttendantDateQueryFamily extends Family<Query<Attendant>> {
  /// See also [attendantDateQuery].
  const AttendantDateQueryFamily();

  /// See also [attendantDateQuery].
  AttendantDateQueryProvider call(
    String date,
  ) {
    return AttendantDateQueryProvider(
      date,
    );
  }

  @override
  AttendantDateQueryProvider getProviderOverride(
    covariant AttendantDateQueryProvider provider,
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
  String? get name => r'attendantDateQueryProvider';
}

/// See also [attendantDateQuery].
class AttendantDateQueryProvider extends AutoDisposeProvider<Query<Attendant>> {
  /// See also [attendantDateQuery].
  AttendantDateQueryProvider(
    this.date,
  ) : super.internal(
          (ref) => attendantDateQuery(
            ref,
            date,
          ),
          from: attendantDateQueryProvider,
          name: r'attendantDateQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendantDateQueryHash,
          dependencies: AttendantDateQueryFamily._dependencies,
          allTransitiveDependencies:
              AttendantDateQueryFamily._allTransitiveDependencies,
        );

  final String date;

  @override
  bool operator ==(Object other) {
    return other is AttendantDateQueryProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$attendantRfidQueryHash() =>
    r'4dd60b441641cf52475a7579a76acea2f4d7f515';
typedef AttendantRfidQueryRef = AutoDisposeProviderRef<Query<Attendant>>;

/// See also [attendantRfidQuery].
@ProviderFor(attendantRfidQuery)
const attendantRfidQueryProvider = AttendantRfidQueryFamily();

/// See also [attendantRfidQuery].
class AttendantRfidQueryFamily extends Family<Query<Attendant>> {
  /// See also [attendantRfidQuery].
  const AttendantRfidQueryFamily();

  /// See also [attendantRfidQuery].
  AttendantRfidQueryProvider call(
    String rfid,
  ) {
    return AttendantRfidQueryProvider(
      rfid,
    );
  }

  @override
  AttendantRfidQueryProvider getProviderOverride(
    covariant AttendantRfidQueryProvider provider,
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
  String? get name => r'attendantRfidQueryProvider';
}

/// See also [attendantRfidQuery].
class AttendantRfidQueryProvider extends AutoDisposeProvider<Query<Attendant>> {
  /// See also [attendantRfidQuery].
  AttendantRfidQueryProvider(
    this.rfid,
  ) : super.internal(
          (ref) => attendantRfidQuery(
            ref,
            rfid,
          ),
          from: attendantRfidQueryProvider,
          name: r'attendantRfidQueryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendantRfidQueryHash,
          dependencies: AttendantRfidQueryFamily._dependencies,
          allTransitiveDependencies:
              AttendantRfidQueryFamily._allTransitiveDependencies,
        );

  final String rfid;

  @override
  bool operator ==(Object other) {
    return other is AttendantRfidQueryProvider && other.rfid == rfid;
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
