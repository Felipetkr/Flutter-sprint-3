import 'package:flutter_test/flutter_test.dart';
import 'package:latteconnect/main.dart';

void main() {
  testWidgets('home shows main Lactare actions', (tester) async {
    await tester.pumpWidget(const LatteConnectApp());

    expect(find.text('Quero doar leite'), findsOneWidget);
    expect(find.text('Preciso de doacao'), findsOneWidget);
    expect(find.text('Encontrar hospital'), findsOneWidget);
    expect(find.text('Conhecer o projeto'), findsOneWidget);
  });
}
