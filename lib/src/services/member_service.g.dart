// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$memberServiceHash() => r'cc91db1210e4adfe645ea0b30a6b2783c006cd44';

/// See also [memberService].
@ProviderFor(memberService)
final memberServiceProvider = AutoDisposeProvider<MemberService>.internal(
  memberService,
  name: r'memberServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$memberServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MemberServiceRef = AutoDisposeProviderRef<MemberService>;
String _$memberStreamHash() => r'b49e83168ca04ffa2c7db7982da95af493dad9a6';

/// See also [memberStream].
@ProviderFor(memberStream)
final memberStreamProvider = AutoDisposeStreamProvider<List<Member>>.internal(
  memberStream,
  name: r'memberStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$memberStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MemberStreamRef = AutoDisposeStreamProviderRef<List<Member>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
