# flutter_riverpod_sqlite_todoapp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


providerの使い方

final counterProvider = StateNotifierProvider<Counter, int>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int> {
  Counter() : super(0);
  void increment() => state++;
}



//  Widget build(BuildContext context, WidgetRef ref) { の中で使ってね
    ref.read(counterProvider.notifier).increment(); //使うとき
    final count = ref.watch(counterProvider); //表示するとき
    Text('$count');

↑readはあまり使わない方がいいらしい

同等だが↓下の方がいい

final counterProvider = StateProvider((ref) => 0);

Widget build(BuildContext context, WidgetRef ref) {
  StateController<int> counter = ref.read(counterProvider.notifier);
  return ElevatedButton(
    onPressed: () => counter.state++,
    child: const Text('button'),
  );
}


final counterProvider = StateProvider((ref) => 0);

Widget build(BuildContext context, WidgetRef ref) {
  StateController<int> counter = ref.watch(counterProvider.notifier);
  return ElevatedButton(
    onPressed: () => counter.state++,
    child: const Text('button'),
  );
}
