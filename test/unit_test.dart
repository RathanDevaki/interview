import 'package:flutter_test/flutter_test.dart';
import 'package:interview/first.dart';

void main() {
  test('unit test ', () {
    String st = 'Hello';
    String op = testFunc(st);
    expect(op, 'Hello~-');
  });
}
