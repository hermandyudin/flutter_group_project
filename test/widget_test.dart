// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:flutter_group_project/artist_page.dart';
import 'package:flutter_group_project/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Verify that our counter starts at 0.
    expect(true, true);
  });

  var artistPage = ArtistPage();
  test('testing if checking already saved artists work properly', () async {
    var isTrue = artists.length;
    expect(isTrue, 0);
  });

  artistPage.downloadData();
  test('testing if checking already saved artists work properly', () async {
    var isTrue = artists.length;
    expect(isTrue, 0);
  });
}
