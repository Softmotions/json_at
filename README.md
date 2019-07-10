# [RFC 6901](https://tools.ietf.org/html/rfc6901) JSON pointer Dart implementation

```dart
/// Gets [obj] sub-property value located by RFC 6901 JSON [pointer].
/// If type of [obj] is string it will be parsed to JSON object used for search.
/// Returns [Optional] value holder.
Optional<dynamic> jsonAt(dynamic obj, String pointer)
```

```dart
import 'package:json_at/json_at.dart';

void main() {
  const doc = {
    'foo': {'bar': 'baz'}
  };
  final val = jsonAt(doc, '/foo/bar');
  print(val.value);
}
```
