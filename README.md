# [RFC 6901](https://tools.ietf.org/html/rfc6901) JSON pointer Dart implementation

```dart
/// Gets [obj] sub-property value located by RFC 6901 JSON [pointer].
/// If type of [obj] is string it will be parsed to JSON object used to search.
/// Returns [Optional] value holder.
Optional<dynamic> jsonAt(dynamic obj, String pointer)
```

```dart
import 'package:json_at/json_at.dart';
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
```
