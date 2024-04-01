// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:loyalty_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Test tap on RaisedButton', (WidgetTester tester) async {

  // Define the callback for when the button is pressed
    var pressed = false;
    final button = RaisedButton(
      onPressed: () => pressed = true,
      child: const Text('Press me'),
    );

    // Build the button in the widget tree
    await tester.pumpWidget(button);

    // Verify the button is in the tree
    expect(find.byType(RaisedButton), findsOneWidget);

    // Tap the button
    await tester.tap(find.byType(RaisedButton));

    // Rebuild the widget after the state has changed
    await tester.pump();

    // Verify the button has been pressed
    expect(pressed, isTrue);
  });

  testWidgets('Test tap and pump', (WidgetTester tester) async {
    var pressed = false;
    final button = MaterialApp(
      home: RaisedButton(
        onPressed: () => pressed = true,
        child: const Text('Press me'),
      ),
    );

    // Build the button in the widget tree
    await tester.pumpWidget(button);

    // Tap the button
    await tester.tap(find.byType(RaisedButton));

    // Rebuild the widget after the state has changed
    await tester.pump();

    // Verify the button has been pressed
    expect(pressed, isTrue);
  });
}
