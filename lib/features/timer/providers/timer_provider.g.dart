// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Sparringtime)
final sparringtimeProvider = SparringtimeProvider._();

final class SparringtimeProvider
    extends $NotifierProvider<Sparringtime, String> {
  SparringtimeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sparringtimeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sparringtimeHash();

  @$internal
  @override
  Sparringtime create() => Sparringtime();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$sparringtimeHash() => r'355cba66a9c4daa52372f269dc90b3f1d2aaaaa4';

abstract class _$Sparringtime extends $Notifier<String> {
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
