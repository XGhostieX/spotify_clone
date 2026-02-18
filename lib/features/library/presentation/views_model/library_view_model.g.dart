// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchFavoriteSongsHash() => r'8b5a538202d513e1697fef48f8045cc31a8581fe';

/// See also [fetchFavoriteSongs].
@ProviderFor(fetchFavoriteSongs)
final fetchFavoriteSongsProvider = AutoDisposeFutureProvider<List<SongModel>>.internal(
  fetchFavoriteSongs,
  name: r'fetchFavoriteSongsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchFavoriteSongsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

// ignore: deprecated_member_use
typedef FetchFavoriteSongsRef = AutoDisposeFutureProviderRef<List<SongModel>>;
String _$libraryViewModelHash() => r'f06a1235d24f4e2a957b91cb84019ad316c49069';

/// See also [LibraryViewModel].
@ProviderFor(LibraryViewModel)
final libraryViewModelProvider =
    AutoDisposeNotifierProvider<LibraryViewModel, AsyncValue?>.internal(
      LibraryViewModel.new,
      name: r'libraryViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$libraryViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LibraryViewModel = AutoDisposeNotifier<AsyncValue?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
