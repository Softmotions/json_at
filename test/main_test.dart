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

  test('unescape of /', () {
    const doc = {'/foo/': 'bar'};
    final v = jsonAt(doc, '/~1foo~1');
    expect(v.value, 'bar');
  });

  test('unescape of ~', () {
    const doc = {'~foo~': 'bar'};
    final v = jsonAt(doc, '/~0foo~0');
    expect(v.value, 'bar');
  });

  test('throw on invalid pointer', () {
    const doc = {'~foo~': 'bar'};
    expect(() => jsonAt(doc, 'pointer'), throwsArgumentError);
  });

  test('throw on invalid pointer 2', () {
    const doc = {'~foo~': 'bar'};
    expect(() => jsonAt(doc, '#pointer'), throwsArgumentError);
  });

  test('empty key', () {
    dynamic doc = {'': 'bar'};
    var v = jsonAt(doc, '/');
    expect(v.value, 'bar');

    doc = {' ': 'bar'};
    v = jsonAt(doc, '/ ');
    expect(v.value, 'bar');

    doc = {
      'bar': {'': 'baz'}
    };
    v = jsonAt(doc, '/bar/');
    expect(v.value, 'baz');
  });

  test('root doc', () {
    const doc = {'foo': 'bar'};
    final v = jsonAt(doc, '');
    expect(v.value, equals({'foo': 'bar'}));
  });

  test('doc as json string', () {
    const doc = '{"foo":"bar"}';
    final v = jsonAt(doc, '/foo');
    expect(v.value, 'bar');
  });
}
