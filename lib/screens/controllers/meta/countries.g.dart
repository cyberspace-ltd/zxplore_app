// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCountriesHash() => r'4ffee073da3a741afb678e60d399114bc36ae7f6';

/// Get getAnticipatedAmount
///
/// Copied from [getCountries].
@ProviderFor(getCountries)
final getCountriesProvider = FutureProvider<List<CountryDatum>?>.internal(
  getCountries,
  name: r'getCountriesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getCountriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetCountriesRef = FutureProviderRef<List<CountryDatum>?>;
String _$getSeaarchableCountriesHash() =>
    r'edfa59abe561ddb41a7a29483cac4d3f35105af6';

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

/// Get getAnticipatedAmount
///
/// Copied from [getSeaarchableCountries].
@ProviderFor(getSeaarchableCountries)
const getSeaarchableCountriesProvider = GetSeaarchableCountriesFamily();

/// Get getAnticipatedAmount
///
/// Copied from [getSeaarchableCountries].
class GetSeaarchableCountriesFamily
    extends Family<AsyncValue<List<CountryDatum>?>> {
  /// Get getAnticipatedAmount
  ///
  /// Copied from [getSeaarchableCountries].
  const GetSeaarchableCountriesFamily();

  /// Get getAnticipatedAmount
  ///
  /// Copied from [getSeaarchableCountries].
  GetSeaarchableCountriesProvider call(
    dynamic searchName,
  ) {
    return GetSeaarchableCountriesProvider(
      searchName,
    );
  }

  @override
  GetSeaarchableCountriesProvider getProviderOverride(
    covariant GetSeaarchableCountriesProvider provider,
  ) {
    return call(
      provider.searchName,
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
  String? get name => r'getSeaarchableCountriesProvider';
}

/// Get getAnticipatedAmount
///
/// Copied from [getSeaarchableCountries].
class GetSeaarchableCountriesProvider
    extends AutoDisposeFutureProvider<List<CountryDatum>?> {
  /// Get getAnticipatedAmount
  ///
  /// Copied from [getSeaarchableCountries].
  GetSeaarchableCountriesProvider(
    dynamic searchName,
  ) : this._internal(
          (ref) => getSeaarchableCountries(
            ref as GetSeaarchableCountriesRef,
            searchName,
          ),
          from: getSeaarchableCountriesProvider,
          name: r'getSeaarchableCountriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSeaarchableCountriesHash,
          dependencies: GetSeaarchableCountriesFamily._dependencies,
          allTransitiveDependencies:
              GetSeaarchableCountriesFamily._allTransitiveDependencies,
          searchName: searchName,
        );

  GetSeaarchableCountriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.searchName,
  }) : super.internal();

  final dynamic searchName;

  @override
  Override overrideWith(
    FutureOr<List<CountryDatum>?> Function(GetSeaarchableCountriesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSeaarchableCountriesProvider._internal(
        (ref) => create(ref as GetSeaarchableCountriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        searchName: searchName,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CountryDatum>?> createElement() {
    return _GetSeaarchableCountriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSeaarchableCountriesProvider &&
        other.searchName == searchName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetSeaarchableCountriesRef
    on AutoDisposeFutureProviderRef<List<CountryDatum>?> {
  /// The parameter `searchName` of this provider.
  dynamic get searchName;
}

class _GetSeaarchableCountriesProviderElement
    extends AutoDisposeFutureProviderElement<List<CountryDatum>?>
    with GetSeaarchableCountriesRef {
  _GetSeaarchableCountriesProviderElement(super.provider);

  @override
  dynamic get searchName =>
      (origin as GetSeaarchableCountriesProvider).searchName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
