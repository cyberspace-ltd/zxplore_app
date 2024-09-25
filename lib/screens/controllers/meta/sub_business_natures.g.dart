// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_business_natures.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getSubBusinessNaturesHash() =>
    r'44bc2ff656cc5ede163ae5faf0ed4e4941abce9d';

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

/// Get getSubBusinessNatures
///
/// Copied from [getSubBusinessNatures].
@ProviderFor(getSubBusinessNatures)
const getSubBusinessNaturesProvider = GetSubBusinessNaturesFamily();

/// Get getSubBusinessNatures
///
/// Copied from [getSubBusinessNatures].
class GetSubBusinessNaturesFamily
    extends Family<AsyncValue<List<SubBusinessNatureDatum>?>> {
  /// Get getSubBusinessNatures
  ///
  /// Copied from [getSubBusinessNatures].
  const GetSubBusinessNaturesFamily();

  /// Get getSubBusinessNatures
  ///
  /// Copied from [getSubBusinessNatures].
  GetSubBusinessNaturesProvider call(
    int? businessNatureId,
  ) {
    return GetSubBusinessNaturesProvider(
      businessNatureId,
    );
  }

  @override
  GetSubBusinessNaturesProvider getProviderOverride(
    covariant GetSubBusinessNaturesProvider provider,
  ) {
    return call(
      provider.businessNatureId,
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
  String? get name => r'getSubBusinessNaturesProvider';
}

/// Get getSubBusinessNatures
///
/// Copied from [getSubBusinessNatures].
class GetSubBusinessNaturesProvider
    extends FutureProvider<List<SubBusinessNatureDatum>?> {
  /// Get getSubBusinessNatures
  ///
  /// Copied from [getSubBusinessNatures].
  GetSubBusinessNaturesProvider(
    int? businessNatureId,
  ) : this._internal(
          (ref) => getSubBusinessNatures(
            ref as GetSubBusinessNaturesRef,
            businessNatureId,
          ),
          from: getSubBusinessNaturesProvider,
          name: r'getSubBusinessNaturesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSubBusinessNaturesHash,
          dependencies: GetSubBusinessNaturesFamily._dependencies,
          allTransitiveDependencies:
              GetSubBusinessNaturesFamily._allTransitiveDependencies,
          businessNatureId: businessNatureId,
        );

  GetSubBusinessNaturesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.businessNatureId,
  }) : super.internal();

  final int? businessNatureId;

  @override
  Override overrideWith(
    FutureOr<List<SubBusinessNatureDatum>?> Function(
            GetSubBusinessNaturesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSubBusinessNaturesProvider._internal(
        (ref) => create(ref as GetSubBusinessNaturesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        businessNatureId: businessNatureId,
      ),
    );
  }

  @override
  FutureProviderElement<List<SubBusinessNatureDatum>?> createElement() {
    return _GetSubBusinessNaturesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSubBusinessNaturesProvider &&
        other.businessNatureId == businessNatureId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, businessNatureId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSubBusinessNaturesRef
    on FutureProviderRef<List<SubBusinessNatureDatum>?> {
  /// The parameter `businessNatureId` of this provider.
  int? get businessNatureId;
}

class _GetSubBusinessNaturesProviderElement
    extends FutureProviderElement<List<SubBusinessNatureDatum>?>
    with GetSubBusinessNaturesRef {
  _GetSubBusinessNaturesProviderElement(super.provider);

  @override
  int? get businessNatureId =>
      (origin as GetSubBusinessNaturesProvider).businessNatureId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
