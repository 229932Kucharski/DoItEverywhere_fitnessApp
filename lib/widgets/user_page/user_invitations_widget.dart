import 'package:die_app/models/user_invitations.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserInvitationWidget extends StatefulWidget {
  const UserInvitationWidget({Key? key}) : super(key: key);

  @override
  _UserInvitationWidgetState createState() => _UserInvitationWidgetState();
}

class _UserInvitationWidgetState extends State<UserInvitationWidget> {
  Future<List<UserInvitation>>? getUserInvitations() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserInvites'))
          ..whereEqualTo('user', currentUser);

    final ParseResponse apiResponse = await queryUserPoints.query();
    List<UserInvitation> userInvitations = [];
    if (apiResponse.success) {
      List<ParseObject> invitations = apiResponse.results as List<ParseObject>;
      for (ParseObject invitation in invitations) {
        String? objectId = invitation.get<String>('objectId');
        ParseObject? to = invitation.get<ParseObject>('user');
        ParseObject? from = invitation.get<ParseObject>('inviteFrom');
        String? username = await getUserName(from!.objectId!);

        UserInvitation userInvitation = UserInvitation(
            objectId: objectId,
            invitationTo: to,
            invitationFrom: from,
            invitationFromUsername: username);
        userInvitations.add(userInvitation);
      }
    }
    return userInvitations;
  }

  Future<String> getUserName(String objectId) async {
    QueryBuilder<ParseObject> queryUserFriends =
        QueryBuilder<ParseObject>(ParseUser.forQuery())
          ..whereEqualTo('objectId', objectId);

    final ParseResponse apiResponse = await queryUserFriends.query();
    if (apiResponse.success) {
      List<ParseObject> users = apiResponse.results as List<ParseObject>;
      return users[0].get("username");
    }
    return "";
  }

  Future<void> deleteInvitation(String objectId) async {
    var invitation = ParseObject('UserInvites')..objectId = objectId;
    await invitation.delete();
  }

  Future<bool> checkIfFriendsAlready(
      ParseObject user, ParseUser currentUser) async {
    QueryBuilder<ParseObject> queryFriends =
        QueryBuilder<ParseObject>(ParseObject('UserFriends'))
          ..whereEqualTo('user', currentUser)
          ..whereEqualTo('friend', user);
    final ParseResponse apiResponse = await queryFriends.query();
    List<ParseObject> objects = apiResponse.results as List<ParseObject>;
    // ignore: unnecessary_null_comparison
    if (objects == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> addFriend(ParseObject from) async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (await checkIfFriendsAlready(from, currentUser!)) {
      return;
    }
    final addFriend = ParseObject('UserFriends')
      ..set('user', currentUser)
      ..set('friend', from);
    await addFriend.save();
    final addFriendRev = ParseObject('UserFriends')
      ..set('user', from)
      ..set('friend', currentUser);
    await addFriendRev.save();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserInvitation>>(
      future: getUserInvitations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 35, bottom: 10),
              child: SizedBox(
                height: 420,
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 10),
                          child: Card(
                            color: const Color(0xFF2F2F2F),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, left: 15, right: 15),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot
                                        .data![index].invitationFromUsername!),
                                    trailing: SizedBox(
                                      width: 120,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add,
                                              size: 30,
                                            ),
                                            onPressed: () async {
                                              await addFriend(snapshot
                                                  .data![index]
                                                  .invitationFrom!);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      duration: Duration(
                                                          milliseconds: 1500),
                                                      content: Text(
                                                          "The invitation has been accepted")));
                                              await deleteInvitation(snapshot
                                                  .data![index].objectId!);
                                              setState(() {});
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 30,
                                            ),
                                            onPressed: () async {
                                              await deleteInvitation(snapshot
                                                  .data![index].objectId!);
                                              setState(() {});
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Padding(
              padding:
                  EdgeInsets.only(left: 35, right: 35, top: 120, bottom: 10),
              child: Text(
                'No invitations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SourceCodePro',
                ),
              ),
            );
          }
        }
        return Column(children: const [
          SizedBox(
            height: 130,
          ),
          CircularProgressIndicator(),
        ]);
      },
    );
  }
}
