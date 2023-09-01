// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'37a0409ad51b4c8d14166e18e91c0c72b51a2811';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = AutoDisposeProvider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthRepositoryRef = AutoDisposeProviderRef<AuthRepository>;
String _$accountsRepositoryHash() =>
    r'8f0ed74c3ff185a1c0233eab11d7a23785839b17';

/// See also [accountsRepository].
@ProviderFor(accountsRepository)
final accountsRepositoryProvider =
    AutoDisposeProvider<AccountsRepository>.internal(
  accountsRepository,
  name: r'accountsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$accountsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AccountsRepositoryRef = AutoDisposeProviderRef<AccountsRepository>;
String _$pemContentHash() => r'355c5b3eb7ce395654272066e8148a66ef3dce9d';

/// See also [pemContent].
@ProviderFor(pemContent)
final pemContentProvider = AutoDisposeProvider<ByteData>.internal(
  pemContent,
  name: r'pemContentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pemContentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PemContentRef = AutoDisposeProviderRef<ByteData>;
String _$keyContentHash() => r'c490da7666bf5a76f6235f9c484769903289ca49';

/// See also [keyContent].
@ProviderFor(keyContent)
final keyContentProvider = AutoDisposeProvider<ByteData>.internal(
  keyContent,
  name: r'keyContentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$keyContentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef KeyContentRef = AutoDisposeProviderRef<ByteData>;
String _$crtContentHash() => r'6e4aa406d365bbaae9d81b2ddd6710c344344ff1';

/// See also [crtContent].
@ProviderFor(crtContent)
final crtContentProvider = AutoDisposeProvider<ByteData>.internal(
  crtContent,
  name: r'crtContentProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$crtContentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CrtContentRef = AutoDisposeProviderRef<ByteData>;
String _$sharedPreferencesHash() => r'75e745127707e465d3f55ce89ddcc932bd72bc2d';

/// See also [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPreferencesRef = ProviderRef<SharedPreferences>;
String _$darkModeHash() => r'6fb7e3f70a5afcbaf176c1312eb244bff5135aef';

/// See also [DarkMode].
@ProviderFor(DarkMode)
final darkModeProvider = AutoDisposeNotifierProvider<DarkMode, bool>.internal(
  DarkMode.new,
  name: r'darkModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$darkModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DarkMode = AutoDisposeNotifier<bool>;
String _$hideBalanceHash() => r'529f78ff14cf46aaaf21584b90c44a0e8f104b89';

/// See also [HideBalance].
@ProviderFor(HideBalance)
final hideBalanceProvider =
    AutoDisposeNotifierProvider<HideBalance, bool>.internal(
  HideBalance.new,
  name: r'hideBalanceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$hideBalanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HideBalance = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
