// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_requests_draft_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPendingRequestsDraftDatumHash() =>
    r'3dc4d1869a6b6ee335d58b5ff796eb3c8c649a6d';

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

/// Get getPendingRequestsDraftDatum
///
/// Copied from [getPendingRequestsDraftDatum].
@ProviderFor(getPendingRequestsDraftDatum)
const getPendingRequestsDraftDatumProvider =
    GetPendingRequestsDraftDatumFamily();

/// Get getPendingRequestsDraftDatum
///
/// Copied from [getPendingRequestsDraftDatum].
class GetPendingRequestsDraftDatumFamily
    extends Family<AsyncValue<List<PendingRequestsDatum>?>> {
  /// Get getPendingRequestsDraftDatum
  ///
  /// Copied from [getPendingRequestsDraftDatum].
  const GetPendingRequestsDraftDatumFamily();

  /// Get getPendingRequestsDraftDatum
  ///
  /// Copied from [getPendingRequestsDraftDatum].
  GetPendingRequestsDraftDatumProvider call(
    BuildContext ctx,
  ) {
    return GetPendingRequestsDraftDatumProvider(
      ctx,
    );
  }

  @override
  GetPendingRequestsDraftDatumProvider getProviderOverride(
    covariant GetPendingRequestsDraftDatumProvider provider,
  ) {
    return call(
      provider.ctx,
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
  String? get name => r'getPendingRequestsDraftDatumProvider';
}

/// Get getPendingRequestsDraftDatum
///
/// Copied from [getPendingRequestsDraftDatum].
class GetPendingRequestsDraftDatumProvider
    extends AutoDisposeFutureProvider<List<PendingRequestsDatum>?> {
  /// Get getPendingRequestsDraftDatum
  ///
  /// Copied from [getPendingRequestsDraftDatum].
  GetPendingRequestsDraftDatumProvider(
    BuildContext ctx,
  ) : this._internal(
          (ref) => getPendingRequestsDraftDatum(
            ref as GetPendingRequestsDraftDatumRef,
            ctx,
          ),
          from: getPendingRequestsDraftDatumProvider,
          name: r'getPendingRequestsDraftDatumProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPendingRequestsDraftDatumHash,
          dependencies: GetPendingRequestsDraftDatumFamily._dependencies,
          allTransitiveDependencies:
              GetPendingRequestsDraftDatumFamily._allTransitiveDependencies,
          ctx: ctx,
        );

  GetPendingRequestsDraftDatumProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ctx,
  }) : super.internal();

  final BuildContext ctx;

  @override
  Override overrideWith(
    FutureOr<List<PendingRequestsDatum>?> Function(
            GetPendingRequestsDraftDatumRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPendingRequestsDraftDatumProvider._internal(
        (ref) => create(ref as GetPendingRequestsDraftDatumRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ctx: ctx,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PendingRequestsDatum>?>
      createElement() {
    return _GetPendingRequestsDraftDatumProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPendingRequestsDraftDatumProvider && other.ctx == ctx;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ctx.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPendingRequestsDraftDatumRef
    on AutoDisposeFutureProviderRef<List<PendingRequestsDatum>?> {
  /// The parameter `ctx` of this provider.
  BuildContext get ctx;
}

class _GetPendingRequestsDraftDatumProviderElement
    extends AutoDisposeFutureProviderElement<List<PendingRequestsDatum>?>
    with GetPendingRequestsDraftDatumRef {
  _GetPendingRequestsDraftDatumProviderElement(super.provider);

  @override
  BuildContext get ctx => (origin as GetPendingRequestsDraftDatumProvider).ctx;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
