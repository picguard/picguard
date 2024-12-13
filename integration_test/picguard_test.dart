// Package imports:
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// Project imports:
import 'package:picguard/main_common.dart';
import 'package:picguard/rust/frb_generated.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => RustLib.init());
  testWidgets('Can call rust function', (WidgetTester tester) async {
    await tester.pumpWidget(const MainApp());
    expect(find.textContaining('Result: `Hello, Tom!`'), findsOneWidget);
  });
}
