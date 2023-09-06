// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendant_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$attendantServiceHash() => r'a36a9011e6d3642cd644dc1a023d6fa39b9a2112';

/// See also [attendantService].
@ProviderFor(attendantService)
final attendantServiceProvider = AutoDisposeProvider<AttendantService>.internal(
  attendantService,
  name: r'attendantServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$attendantServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AttendantServiceRef = AutoDisposeProviderRef<AttendantService>;
String _$attendantByDateStreamHash() =>
    r'd8458147532aa67e5aed5550c5ab20033aff34c1';

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

typedef AttendantByDateStreamRef
    = AutoDisposeStreamProviderRef<List<Attendant>>;

/// See also [attendantByDateStream].
@ProviderFor(attendantByDateStream)
const attendantByDateStreamProvider = AttendantByDateStreamFamily();

/// See also [attendantByDateStream].
class AttendantByDateStreamFamily extends Family<AsyncValue<List<Attendant>>> {
  /// See also [attendantByDateStream].
  const AttendantByDateStreamFamily();

  /// See also [attendantByDateStream].
  AttendantByDateStreamProvider call(
    String type,
  ) {
    return AttendantByDateStreamProvider(
      type,
    );
  }

  @override
  AttendantByDateStreamProvider getProviderOverride(
    covariant AttendantByDateStreamProvider provider,
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
  String? get name => r'attendantByDateStreamProvider';
}

/// See also [attendantByDateStream].
class AttendantByDateStreamProvider
    extends AutoDisposeStreamProvider<List<Attendant>> {
  /// See also [attendantByDateStream].
  AttendantByDateStreamProvider(
    this.type,
  ) : super.internal(
          (ref) => attendantByDateStream(
            ref,
            type,
          ),
          from: attendantByDateStreamProvider,
          name: r'attendantByDateStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendantByDateStreamHash,
          dependencies: AttendantByDateStreamFamily._dependencies,
          allTransitiveDependencies:
              AttendantByDateStreamFamily._allTransitiveDependencies,
        );

  final String type;

  @override
  bool operator ==(Object other) {
    return other is AttendantByDateStreamProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$attendantByRfidStreamHash() =>
    r'3892caf6c7010af7b95494f8cc594b092c89ac09';
typedef AttendantByRfidStreamRef
    = AutoDisposeStreamProviderRef<List<Attendant>>;

/// See also [attendantByRfidStream].
@ProviderFor(attendantByRfidStream)
const attendantByRfidStreamProvider = AttendantByRfidStreamFamily();

/// See also [attendantByRfidStream].
class AttendantByRfidStreamFamily extends Family<AsyncValue<List<Attendant>>> {
  /// See also [attendantByRfidStream].
  const AttendantByRfidStreamFamily();

  /// See also [attendantByRfidStream].
  AttendantByRfidStreamProvider call(
    String type,
  ) {
    return AttendantByRfidStreamProvider(
      type,
    );
  }

  @override
  AttendantByRfidStreamProvider getProviderOverride(
    covariant AttendantByRfidStreamProvider provider,
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
  String? get name => r'attendantByRfidStreamProvider';
}

/// See also [attendantByRfidStream].
class AttendantByRfidStreamProvider
    extends AutoDisposeStreamProvider<List<Attendant>> {
  /// See also [attendantByRfidStream].
  AttendantByRfidStreamProvider(
    this.type,
  ) : super.internal(
          (ref) => attendantByRfidStream(
            ref,
            type,
          ),
          from: attendantByRfidStreamProvider,
          name: r'attendantByRfidStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$attendantByRfidStreamHash,
          dependencies: AttendantByRfidStreamFamily._dependencies,
          allTransitiveDependencies:
              AttendantByRfidStreamFamily._allTransitiveDependencies,
        );

  final String type;

  @override
  bool operator ==(Object other) {
    return other is AttendantByRfidStreamProvider && other.type == type;
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
