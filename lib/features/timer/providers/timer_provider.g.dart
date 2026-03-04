// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SparringTime)
final sparringTimeProvider = SparringTimeProvider._();

final class SparringTimeProvider
    extends $NotifierProvider<SparringTime, String> {
  SparringTimeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sparringTimeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sparringTimeHash();

  @$internal
  @override
  SparringTime create() => SparringTime();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$sparringTimeHash() => r'd5fa5ad0e77b33ada801876bdd0c69f7e8ae39d6';

abstract class _$SparringTime extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(RestTime)
final restTimeProvider = RestTimeProvider._();

final class RestTimeProvider extends $NotifierProvider<RestTime, String> {
  RestTimeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restTimeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restTimeHash();

  @$internal
  @override
  RestTime create() => RestTime();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$restTimeHash() => r'cc60e6829de436abed5469b7298f1dc08283431d';

abstract class _$RestTime extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(Rounds)
final roundsProvider = RoundsProvider._();

final class RoundsProvider extends $NotifierProvider<Rounds, int> {
  RoundsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roundsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roundsHash();

  @$internal
  @override
  Rounds create() => Rounds();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$roundsHash() => r'482ba32d3395926654be0b99facaa222b2064510';

abstract class _$Rounds extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
