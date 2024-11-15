// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_account_class.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAccountClassHash() => r'5bdbab4d8a9f930c9ca0d87ebef4df5092ee960f';

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

/// Get getGender
///
/// Copied from [getAccountClass].
@ProviderFor(getAccountClass)
const getAccountClassProvider = GetAccountClassFamily();

/// Get getGender
///
/// Copied from [getAccountClass].
class GetAccountClassFamily
    extends Family<AsyncValue<List<AccountClassDatum>?>> {
  /// Get getGender
  ///
  /// Copied from [getAccountClass].
  const GetAccountClassFamily();

  /// Get getGender
  ///
  /// Copied from [getAccountClass].
  GetAccountClassProvider call(
    String? accountTypeValue,
    String? seriesCodeValue,
  ) {
    return GetAccountClassProvider(
      accountTypeValue,
      seriesCodeValue,
    );
  }

  @override
  GetAccountClassProvider getProviderOverride(
    covariant GetAccountClassProvider provider,
  ) {
    return call(
      provider.accountTypeValue,
      provider.seriesCodeValue,
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
  String? get name => r'getAccountClassProvider';
}

/// Get getGender
///
/// Copied from [getAccountClass].
class GetAccountClassProvider extends FutureProvider<List<AccountClassDatum>?> {
  /// Get getGender
  ///
  /// Copied from [getAccountClass].
  GetAccountClassProvider(
    String? accountTypeValue,
    String? seriesCodeValue,
  ) : this._internal(
          (ref) => getAccountClass(
            ref as GetAccountClassRef,
            accountTypeValue,
            seriesCodeValue,
          ),
          from: getAccountClassProvider,
          name: r'getAccountClassProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getAccountClassHash,
          dependencies: GetAccountClassFamily._dependencies,
          allTransitiveDependencies:
              GetAccountClassFamily._allTransitiveDependencies,
          accountTypeValue: accountTypeValue,
          seriesCodeValue: seriesCodeValue,
        );

  GetAccountClassProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.accountTypeValue,
    required this.seriesCodeValue,
  }) : super.internal();

  final String? accountTypeValue;
  final String? seriesCodeValue;

  @override
  Override overrideWith(
    FutureOr<List<AccountClassDatum>?> Function(GetAccountClassRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetAccountClassProvider._internal(
        (ref) => create(ref as GetAccountClassRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        accountTypeValue: accountTypeValue,
        seriesCodeValue: seriesCodeValue,
      ),
    );
  }

  @override
  FutureProviderElement<List<AccountClassDatum>?> createElement() {
    return _GetAccountClassProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetAccountClassProvider &&
        other.accountTypeValue == accountTypeValue &&
        other.seriesCodeValue == seriesCodeValue;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, accountTypeValue.hashCode);
    hash = _SystemHash.combine(hash, seriesCodeValue.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetAccountClassRef on FutureProviderRef<List<AccountClassDatum>?> {
  /// The parameter `accountTypeValue` of this provider.
  String? get accountTypeValue;

  /// The parameter `seriesCodeValue` of this provider.
  String? get seriesCodeValue;
}

class _GetAccountClassProviderElement
    extends FutureProviderElement<List<AccountClassDatum>?>
    with GetAccountClassRef {
  _GetAccountClassProviderElement(super.provider);

  @override
  String? get accountTypeValue =>
      (origin as GetAccountClassProvider).accountTypeValue;
  @override
  String? get seriesCodeValue =>
      (origin as GetAccountClassProvider).seriesCodeValue;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
