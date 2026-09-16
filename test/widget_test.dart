import 'package:blood_donor/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app launches login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const CommunityBloodDonorApp());

    expect(find.text('COMMUNITY BLOOD DONOR'), findsOneWidget);
  });
}
