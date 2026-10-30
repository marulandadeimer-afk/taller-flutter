import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/presentation/pages/splash_page.dart';

void main() {
  testWidgets('Smoke test inicial de UserMaster', (WidgetTester tester) async {
    await tester.pumpWidget(const UserMasterApp());
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.text('UserMaster'), findsOneWidget);
  });
}
