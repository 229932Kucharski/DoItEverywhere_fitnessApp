import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserInvitation {
  String? objectId;
  ParseObject? invitationTo;
  ParseObject? invitationFrom;
  String? invitationFromUsername;

  UserInvitation({
    required this.objectId,
    required this.invitationTo,
    required this.invitationFrom,
    required this.invitationFromUsername,
  });
}
