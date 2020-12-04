import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task_flutter/screens/product_details/components/size_select.dart';
import 'package:tech_task_flutter/models/product.dart';

void main() {
  group('Size selector', () {
    Product testProduct = Product(
        id: '1',
        name: 'Nike Air Relentless 4 Mens Running Shoes',
        sizes: ['8', '9', '10', '11']);

    testWidgets('Product sizes display', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SizeSelect(product: testProduct))),
      );

      expect(find.text('8'), findsOneWidget);
      expect(find.text('9'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('11'), findsOneWidget);
      expect(find.text('12'), findsNothing);
      expect(find.byType(FlatButton), findsNothing);
    });

    testWidgets('Choose selected size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SizeSelect(product: testProduct))),
      );

      await tester.tap(find.text('8'));
      await tester.pump();

      final FlatButton selectedSizeButton =
          tester.firstWidget(find.byType(FlatButton));
      expect(
          selectedSizeButton.child,
          isA<Text>().having(
            (t) => t.data,
            'data',
            '8',
          ));
    });

    testWidgets('Change selected size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: SizeSelect(product: testProduct))),
      );

      await tester.tap(find.text('8'));
      await tester.pump();

      await tester.tap(find.text('9'));
      await tester.pump();

      final FlatButton selectedSizeButton =
          tester.firstWidget(find.byType(FlatButton));
      expect(
          selectedSizeButton.child,
          isA<Text>().having(
            (t) => t.data,
            'data',
            '9',
          ));
    });
  });
}
