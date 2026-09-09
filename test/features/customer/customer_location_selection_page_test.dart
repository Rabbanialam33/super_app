import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_app/features/customer/presentation/pages/customer_location_selection_page.dart';

void main() {
  Widget buildTestApp() {
    return const MaterialApp(
      home: CustomerLocationSelectionPage(),
    );
  }

  Future<void> scrollToBottom(WidgetTester tester) async {
    final listView = find.byType(ListView).first;

    await tester.drag(
      listView,
      const Offset(0, -1200),
    );

    await tester.pumpAndSettle();
  }

  Future<void> fillValidLocation(WidgetTester tester) async {
    final fields = find.byType(TextFormField);

    await tester.enterText(fields.at(0), 'Home');
    await tester.enterText(fields.at(1), 'Dhupguri Town');
    await tester.enterText(fields.at(2), 'West Bengal');
    await tester.enterText(fields.at(3), 'Jalpaiguri');
    await tester.enterText(fields.at(4), 'Dhupguri');
    await tester.enterText(fields.at(5), 'Dhupguri Town');
    await tester.enterText(fields.at(6), '735210');

    await tester.pump();
  }

  Future<void> checkLocation(WidgetTester tester) async {
    await scrollToBottom(tester);

    await tester.tap(
      find.text('Check Service Availability'),
    );

    await tester.pumpAndSettle();

    await scrollToBottom(tester);
  }

  group('CustomerLocationSelectionPage', () {
    testWidgets(
      'renders location selection page correctly',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        expect(
          find.text('Select Location'),
          findsOneWidget,
        );

        expect(
          find.text('Choose your location'),
          findsOneWidget,
        );

        expect(
          find.text(
            'Enter your area to see services available near you.',
          ),
          findsOneWidget,
        );

        expect(
          find.text('Location Name'),
          findsOneWidget,
        );

        expect(
          find.text('Address'),
          findsOneWidget,
        );

        expect(
          find.text('State'),
          findsOneWidget,
        );

        expect(
          find.text('District'),
          findsOneWidget,
        );

        expect(
          find.text('City / Town'),
          findsOneWidget,
        );

        expect(
          find.text('Area'),
          findsOneWidget,
        );

        expect(
          find.text('PIN Code'),
          findsOneWidget,
        );

        await scrollToBottom(tester);

        expect(
          find.text('Check Service Availability'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'shows validation errors for empty form',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        await scrollToBottom(tester);

        await tester.tap(
          find.text('Check Service Availability'),
        );

        await tester.pump();

        expect(
          find.text('Location Name is required'),
          findsOneWidget,
        );

        expect(
          find.text('Address is required'),
          findsOneWidget,
        );

        expect(
          find.text('State is required'),
          findsOneWidget,
        );

        expect(
          find.text('District is required'),
          findsOneWidget,
        );

        expect(
          find.text('City / Town is required'),
          findsOneWidget,
        );

        expect(
          find.text('Area is required'),
          findsOneWidget,
        );

        expect(
          find.text('PIN Code is required'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'shows validation error for invalid PIN code',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        final fields = find.byType(TextFormField);

        await tester.enterText(fields.at(0), 'Home');
        await tester.enterText(fields.at(1), 'Dhupguri Town');
        await tester.enterText(fields.at(2), 'West Bengal');
        await tester.enterText(fields.at(3), 'Jalpaiguri');
        await tester.enterText(fields.at(4), 'Dhupguri');
        await tester.enterText(fields.at(5), 'Dhupguri Town');
        await tester.enterText(fields.at(6), '12345');

        await tester.pump();

        await scrollToBottom(tester);

        await tester.tap(
          find.text('Check Service Availability'),
        );

        await tester.pump();

        expect(
          find.text('Enter a valid 6 digit PIN code'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'checks service availability for supported Dhupguri location',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        await fillValidLocation(tester);

        await checkLocation(tester);

        expect(
          find.text('Location is available in your area'),
          findsOneWidget,
        );

        expect(
          find.text('Confirm Location'),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'shows unavailable message for unsupported location',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        final fields = find.byType(TextFormField);

        await tester.enterText(fields.at(0), 'Home');
        await tester.enterText(fields.at(1), 'Kolkata');
        await tester.enterText(fields.at(2), 'West Bengal');
        await tester.enterText(fields.at(3), 'Kolkata');
        await tester.enterText(fields.at(4), 'Kolkata');
        await tester.enterText(fields.at(5), 'Kolkata');
        await tester.enterText(fields.at(6), '700001');

        await tester.pump();

        await checkLocation(tester);

        expect(
          find.text(
            'Service is not available in your area yet',
          ),
          findsOneWidget,
        );

        expect(
          find.text('Confirm Location'),
          findsNothing,
        );
      },
    );

    testWidgets(
      'confirm button appears after successful location check',
      (WidgetTester tester) async {
        await tester.pumpWidget(buildTestApp());

        expect(
          find.text('Confirm Location'),
          findsNothing,
        );

        await fillValidLocation(tester);

        await checkLocation(tester);

        expect(
          find.text('Location is available in your area'),
          findsOneWidget,
        );

        expect(
          find.text('Confirm Location'),
          findsOneWidget,
        );
      },
    );
  });
}