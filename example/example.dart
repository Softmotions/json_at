import 'package:json_at/json_at.dart';

void main() {
  const doc = {
    'foo': {'bar': 'baz'}
  };
  final val = jsonAt(doc, '/foo/bar');
  print(val.value);
}
