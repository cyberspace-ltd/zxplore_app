// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_series.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAccountSeriesHash() => r'fe19c99f7ff10ada3e23b6f10f0bdc8bb8ad0a3c';

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

/// Get getAccountSeries
///
/// Copied from [getAccountSeries].
@ProviderFor(getAccountSeries)
const getAccountSeriesProvider = GetAccountSeriesFamily();

/// Get getAccountSeries
///
/// Copied from [getAccountSeries].
class GetAccountSeriesFamily
    extends Family<AsyncValue<List<AccountSeriesDatum>?>> {
  /// Get getAccountSeries
  ///
  /// Copied from [getAccountSeries].
  const GetAccountSeriesFamily();

  /// Get getAccountSeries
  ///
  /// Copied from [getAccountSeries].
  GetAccountSeriesProvider call(
    String? accountType,
  ) {
    return GetAccountSeriesProvider(
      accountType,
    );
  }

  @override
  GetAccountSeriesProvider getProviderOverride(
    covariant GetAccountSeriesProvider provider,
  ) {
    return call(
      provider.accountType,
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
  String? get name => r'getAccountSeriesProvider';
}

/// Get getAccountSeries
///
/// Copied from [getAccountSeries].
class GetAccountSeriesProvider
    extends FutureProvider<List<AccountSeriesDatum>?> {
  /// Get getAccountSeries
  ///
  /// Copied from [getAccountSeries].
  GetAccountSeriesProvider(
    String? accountType,
  ) : this._internal(
          (ref) => getAccountSeries(
            ref as GetAccountSeriesRef,
            accountType,
          ),
          from: getAccountSeriesProvider,
          name: r'getAccountSeriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAccountSeriesHash,
          dependencies: GetAccountSeriesFamily._dependencies,
          allTransitiveDependencies:
              GetAccountSeriesFamily._allTransitiveDependencies,
          accountType: accountType,
        );

  GetAccountSeriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountType,
  }) : super.internal();

  final String? accountType;

  @override
  Override overrideWith(
    FutureOr<List<AccountSeriesDatum>?> Function(GetAccountSeriesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAccountSeriesProvider._internal(
        (ref) => create(ref as GetAccountSeriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accountType: accountType,
      ),
    );
  }

  @override
  FutureProviderElement<List<AccountSeriesDatum>?> createElement() {
    return _GetAccountSeriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAccountSeriesProvider &&
        other.accountType == accountType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAccountSeriesRef on FutureProviderRef<List<AccountSeriesDatum>?> {
  /// The parameter `accountType` of this provider.
  String? get accountType;
}

class _GetAccountSeriesProviderElement
    extends FutureProviderElement<List<AccountSeriesDatum>?>
    with GetAccountSeriesRef {
  _GetAccountSeriesProviderElement(super.provider);

  @override
  String? get accountType => (origin as GetAccountSeriesProvider).accountType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
