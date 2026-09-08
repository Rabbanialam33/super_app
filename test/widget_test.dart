import 'package:flutter_test/flutter_test.dart';
import 'package:super_app/main.dart';

void main() {
  testWidgets('Super App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const SuperApp());

    expect(find.text('Super App'), findsOneWidget);
  });
}