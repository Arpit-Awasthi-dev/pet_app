import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pet_app/presentation/pages/home_page/home_page.dart';

void main(){
  group('Test light-dark mode', (){
    testWidgets('check clicks', (WidgetTester tester) async{
      await tester.pumpWidget(const HomePage());

      await GlobalMaterialLocalizations.delegate.load(const Locale('en'));

      expect(find.byIcon(Icons.light_mode), findsOneWidget);
      expect(find.byIcon(Icons.dark_mode), findsNothing);

      await tester.tap(find.byIcon(Icons.light_mode));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.dark_mode), findsOneWidget);
      expect(find.byIcon(Icons.light_mode), findsNothing);

    });
  });
}