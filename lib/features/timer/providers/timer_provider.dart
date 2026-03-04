import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_provider.g.dart';

@riverpod
class SparringTime extends _$SparringTime {
  @override
  String build() => "05:00";
}

@riverpod
class RestTime extends _$RestTime {
  @override
  String build() => "01:00";
}

@riverpod
class Rounds extends _$Rounds {
  @override
  int build() => 10;
}
