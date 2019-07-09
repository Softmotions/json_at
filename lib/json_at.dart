import 'dart:convert' as convert_lib;
import 'dart:core';

import 'package:quiver/core.dart';

Optional<dynamic> jsonAt(dynamic obj, String pointer) {
  if (obj is String) {
    obj = convert_lib.jsonDecode(obj as String);
  }
  if (obj is Map || obj is List) {
    return _traverse(obj, _parsePointer(pointer));
  } else {
    return const Optional<dynamic>.absent();
  }
}

List<String> _parsePointer(String pointer) {
  if (pointer.startsWith('#')) {
    pointer = Uri.decodeComponent(pointer).substring(1);
  }
  if (pointer.isEmpty || pointer[0] != '/') {
    throw ArgumentError.value(pointer, 'pointer');
  }
  return pointer.substring(1).split('/').map((p) {
    return p.replaceAll('~1', '/').replaceAll('~0', '~');
  }).toList();
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
