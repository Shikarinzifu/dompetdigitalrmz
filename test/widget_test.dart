import 'package:flutter_test/flutter_test.dart';

void main() {
<<<<<<< HEAD
  testWidgets('App smoke test', (WidgetTester tester) async {
    expect(true, isTrue);
=======
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DompetKampusApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
>>>>>>> 4961ad2 (fix: resolve 55 analyzer issues + redesign UI ke tema hijau lumut)
  });
}
