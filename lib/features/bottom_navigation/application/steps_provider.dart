import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

final stepsProvider = StateProvider<StepCount?>((ref) => null);
final pointsProvider =
    StateProvider<int>((ref) => (ref.watch(stepsProvider)?.steps ?? 0) ~/ 100);
