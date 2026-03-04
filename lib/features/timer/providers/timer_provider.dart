import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_provider.g.dart';

@riverpod
class Sparringtime extends _$Sparringtime {
  @override
  String build() {
    return "05:00";
  }
}
