import 'package:project_social/framework/extensions.dart';

//const String _base62Chars = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
const String _base62Rand = "Up0DNILisgVjfzydHR2vCJt69FeS3uhQGm7x5EnKWl1broqXw8akA4YTOZPMBc";

/// Has an email address into a firebase-like id (`g3scydHR2vCJt69FeS3u`) \
/// `String hashed = hash62("account@example.com");`
String hash62(String src, {int length = 20}) {
  // a@b.c
  final str = "$src@?%${src.reverse()}&!#$src";
  String out = "";

  for (int i = 0; i < length; i++) {
    out += _base62Rand[str.codeUnitAt(i) % 62];
  }

  return out;
}
