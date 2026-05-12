import 'package:flutter_test/flutter_test.dart';
import 'package:tugas1/main.dart';

void main() {
  testWidgets('Aplikasi dapat dimuat', (WidgetTester tester) async {
    await tester.pumpWidget(const AplikasiUtama());
    expect(find.text('Memuat...'), findsOneWidget);
  });
}
