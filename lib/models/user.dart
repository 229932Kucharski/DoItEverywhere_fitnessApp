import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class User {
  ParseObject? objectId;
  String? name;
  int? points;
  ParseFileBase? avatar;

  User({
    required this.objectId,
    required this.name,
    required this.points,
    required this.avatar,
  });
}
