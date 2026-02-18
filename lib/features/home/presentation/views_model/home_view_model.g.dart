// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchRemoteSongsHash() => r'c170a603d02bc02245048bdb7fa35471b968b47f';

/// See also [fetchRemoteSongs].
@ProviderFor(fetchRemoteSongs)
final fetchRemoteSongsProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  fetchRemoteSongs,
  name: r'fetchRemoteSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchRemoteSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

// ignore: deprecated_member_use
typedef FetchRemoteSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$homeViewModelHash() => r'6ca223b5dad2444b6757dc48c64bc019e1f76c86';

/// See also [HomeViewModel].
@ProviderFor(HomeViewModel)
final homeViewModelProvider = AutoDisposeNotifierProvider<HomeViewModel, AsyncValue?>.internal(
  HomeViewModel.new,
  name: r'homeViewModelProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeViewModelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
