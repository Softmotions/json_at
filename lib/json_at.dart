import 'dart:convert' as convert_lib;
import 'dart:core';

import 'package:quiver/core.dart';

/// Gets [obj] sub-property value located by RFC 6901 JSON [pointer].
/// If type of [obj] is string it will be parsed to JSON object used for search.
/// Returns [Optional] value holder.
Optional<dynamic> jsonAt(dynamic obj, String pointer) {
  if (obj is String) {
    obj = convert_lib.jsonDecode(obj as String);
  }
  if (pointer.isEmpty) {
    return Optional<dynamic>.of(obj);
  }
  if (obj is Map || obj is List) {
    return _traverse(obj, _pointer(pointer));
  } else {
    return const Optional<dynamic>.absent();
  }
}

List<String> _pointer(String pointer) {
  if (pointer.startsWith('#')) {
    pointer = Uri.decodeComponent(pointer).substring(1);
  }
  if (pointer.isEmpty || pointer[0] != '/') {
    throw ArgumentError.value(pointer, 'pointer');
  }
  return pointer
      .substring(1)
      .split('/')
      .map((p) => p.replaceAll('~1', '/').replaceAll('~0', '~'))
      .toList();
}

Optional<dynamic> _traverse(dynamic obj, List<String> pp) {
  if (pp.isEmpty) {
    return Optional<dynamic>.of(obj);
  }
  final key = pp.removeAt(0);
  if (obj is Map) {
    if (!obj.containsKey(key)) {
      return const Optional<dynamic>.absent();
    }
    return _traverse(obj[key], pp);
  } else if (obj is List) {
    final ikey = int.tryParse(key);
    if (ikey == null || ikey < 0 || ikey >= obj.length) {
      return const Optional<dynamic>.absent();
    }
    return _traverse(obj[ikey], pp);
  } else {
    return const Optional<dynamic>.absent();
  }
}
