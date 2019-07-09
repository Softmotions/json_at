import 'package:test/test.dart';
import 'package:json_at/json_at.dart';

void main() {
  test('get at 1', () {
    const doc = {
      'foo': {
        'bar': {
          'baz': [
            {'gaz': 33}
          ]
        }
      }
    };
    final v = jsonAt(doc, '/foo/bar/baz/0/gaz');
    expect(v.isPresent, isTrue);
    expect(v.value, equals(33));
  });

  test('absent if value is not exist', () {
    const doc = {'foo': 'baz'};
    final v = jsonAt(doc, '/bar');
    expect(v.isPresent, isFalse);
  });

  test('decodes fragment pointer', () {
    const doc = {'c%d': 1};
    final v = jsonAt(doc, '#/c%25d');
    expect(v.value, equals(1));
  });
}
