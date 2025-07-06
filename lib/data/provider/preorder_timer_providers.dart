import 'package:flutter_riverpod/flutter_riverpod.dart';

final deadlineProvider = Provider<DateTime>((ref) {
  return DateTime(2025, 10, 30, 18, 0, 0);
});

final currentTimeProvider = StreamProvider<DateTime>((ref) async* {
  while (true) {
    yield DateTime.now();
    await Future.delayed(const Duration(seconds: 1));
  }
});

final remainingTimeProvider = Provider<Duration?>((ref) {
  final deadline = ref.watch(deadlineProvider);
  final nowAsync = ref.watch(currentTimeProvider);

  return nowAsync.when(
    data: (now) => deadline.difference(now),
    loading: () => null,
    error: (err, stack) => null,
  );
});
