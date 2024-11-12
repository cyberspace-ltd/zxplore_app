// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_login_modes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLoginModesHash() => r'140aa571c73149d665419a9811a3ddfa417e4223';

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

/// Get getLoginModes
///
/// Copied from [getLoginModes].
@ProviderFor(getLoginModes)
const getLoginModesProvider = GetLoginModesFamily();

/// Get getLoginModes
///
/// Copied from [getLoginModes].
class GetLoginModesFamily extends Family<AsyncValue<List<LoginModesData>?>> {
  /// Get getLoginModes
  ///
  /// Copied from [getLoginModes].
  const GetLoginModesFamily();

  /// Get getLoginModes
  ///
  /// Copied from [getLoginModes].
  GetLoginModesProvider call(
    BuildContext context,
  ) {
    return GetLoginModesProvider(
      context,
    );
  }

  @override
  GetLoginModesProvider getProviderOverride(
    covariant GetLoginModesProvider provider,
  ) {
    return call(
      provider.context,
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
  String? get name => r'getLoginModesProvider';
}

/// Get getLoginModes
///
/// Copied from [getLoginModes].
class GetLoginModesProvider
    extends AutoDisposeFutureProvider<List<LoginModesData>?> {
  /// Get getLoginModes
  ///
  /// Copied from [getLoginModes].
  GetLoginModesProvider(
    BuildContext context,
  ) : this._internal(
          (ref) => getLoginModes(
            ref as GetLoginModesRef,
            context,
          ),
          from: getLoginModesProvider,
          name: r'getLoginModesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getLoginModesHash,
          dependencies: GetLoginModesFamily._dependencies,
          allTransitiveDependencies:
              GetLoginModesFamily._allTransitiveDependencies,
          context: context,
        );

  GetLoginModesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  Override overrideWith(
    FutureOr<List<LoginModesData>?> Function(GetLoginModesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetLoginModesProvider._internal(
        (ref) => create(ref as GetLoginModesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<LoginModesData>?> createElement() {
    return _GetLoginModesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetLoginModesProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetLoginModesRef on AutoDisposeFutureProviderRef<List<LoginModesData>?> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _GetLoginModesProviderElement
    extends AutoDisposeFutureProviderElement<List<LoginModesData>?>
    with GetLoginModesRef {
  _GetLoginModesProviderElement(super.provider);

  @override
  BuildContext get context => (origin as GetLoginModesProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
