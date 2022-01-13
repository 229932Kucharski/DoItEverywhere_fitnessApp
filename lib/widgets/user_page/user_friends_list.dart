import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:die_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:die_app/addidtional/globals.dart' as globals;

class UserFriendsList extends StatefulWidget {
  const UserFriendsList({Key? key}) : super(key: key);

  @override
  _UserFriendsListState createState() => _UserFriendsListState();
}

class _UserFriendsListState extends State<UserFriendsList> {
  Future<List<User>>? getUserFriends() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserFriends =
        QueryBuilder<ParseObject>(ParseObject('UserFriends'))
          ..whereEqualTo('user', currentUser);

    final ParseResponse apiResponse = await queryUserFriends.query();
    List<User> friends = [];
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> users = apiResponse.results as List<ParseObject>;
      // ignore: unnecessary_null_comparison
      if (users == null) {
        return friends;
      }
      List<ParseObject>? allUsers = await getUsers();
      List<ParseObject>? allUsersData = await getUsersData();
      for (ParseObject friend in users) {
        ParseObject? objectId = friend.get<ParseObject>('friend');
        String? name = getUserName(allUsers!, objectId!.objectId!);
        int? points = getUserPoints(allUsersData!, objectId.objectId!);
        ParseFileBase? avatar = getUserAvatar(allUsersData, objectId.objectId!);
        User user = User(
            objectId: objectId, name: name, points: points, avatar: avatar);
        friends.add(user);
      }
    }
    friends.sort((a, b) => b.points!.compareTo(a.points!));
    return friends;
  }

  Future<List<ParseObject>?> getUsers() async {
    QueryBuilder<ParseObject> queryUserFriends =
        QueryBuilder<ParseObject>(ParseUser.forQuery());
    final ParseResponse apiResponse = await queryUserFriends.query();
    if (apiResponse.success) {
      List<ParseObject> users = apiResponse.results as List<ParseObject>;
      return users;
    }
    return null;
  }

  Future<List<ParseObject>?> getUsersData() async {
    QueryBuilder<ParseObject> queryUserFriends =
        QueryBuilder<ParseObject>(ParseObject('UserData'));
    final ParseResponse apiResponse = await queryUserFriends.query();
    if (apiResponse.success) {
      List<ParseObject> usersData = apiResponse.results as List<ParseObject>;
      return usersData;
    }
    return null;
  }

  String getUserName(List<ParseObject> users, String objectId) {
    for (ParseObject user in users) {
      if (user.objectId == objectId) {
        return user.get("username");
      }
    }
    return "";
  }

  int getUserPoints(List<ParseObject> users, String objectId) {
    for (ParseObject user in users) {
      if (user.get("user").get("objectId") == objectId) {
        return user.get("points");
      }
    }
    return 0;
  }

  ParseFileBase? getUserAvatar(List<ParseObject> users, String objectId) {
    for (ParseObject user in users) {
      if (user.get("user").get("objectId") == objectId) {
        return user.get<ParseFileBase>('avatar');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: getUserFriends(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 60, right: 60, top: 120, bottom: 10),
              child: Column(
                children: [
                  const Text(
                    'Invite some friends to see their results',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SourceCodePro',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.refresh_rounded,
                      size: 35,
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(5),
                        child: dataBody(snapshot.data!, context)),
                  )
                ],
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          const Text("Check your internet conncetion");
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

  SingleChildScrollView dataBody(List<User> friends, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortColumnIndex: 0,
        showCheckboxColumn: false,
        columns: const [
          DataColumn(
            label: Text(""),
            numeric: false,
          ),
          DataColumn(label: Text("Name"), numeric: false),
          DataColumn(
            label: Text("Points"),
            numeric: false,
          ),
        ],
        rows: friends
            .map(
              (friend) => DataRow(cells: [
                DataCell(
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: (friend.avatar != null)
                        ? Image.network(
                            friend.avatar!.url!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.contain,
                          ).image
                        : Image.asset(
                            'assets/users/avatar.png',
                            width: 40,
                            height: 40,
                          ).image,
                  ),
                ),
                DataCell(Text(friend.name!), onLongPress: () async {
                  if (await confirm(
                    context,
                    title: const Text('Confirm'),
                    content: const Text('Would you like to delete friend?'),
                    textOK: const Text('Yes'),
                    textCancel: const Text('No'),
                  )) {
                    await deleteFriend(friend.objectId!);
                  }
                }),
                DataCell(
                  Text(((friend.points! / globals.maxPoints) * 100)
                          .toInt()
                          .toString() +
                      "%"),
                ),
              ]),
            )
            .toList(),
      ),
    );
  }

  Future<void> deleteFriend(ParseObject user) async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserFriends =
        QueryBuilder<ParseObject>(ParseObject('UserFriends'))
          ..whereEqualTo("user", currentUser)
          ..whereEqualTo("friend", user);
    final ParseResponse apiResponse = await queryUserFriends.query();
    if (apiResponse.success) {
      List<ParseObject> users = apiResponse.results as List<ParseObject>;
      var friend = ParseObject('UserFriends')..objectId = users[0].objectId;
      await friend.delete();
    }

    queryUserFriends = QueryBuilder<ParseObject>(ParseObject('UserFriends'))
      ..whereEqualTo("friend", currentUser)
      ..whereEqualTo("user", user);
    final ParseResponse apiResponse2 = await queryUserFriends.query();
    if (apiResponse2.success) {
      List<ParseObject> users = apiResponse2.results as List<ParseObject>;
      var friend = ParseObject('UserFriends')..objectId = users[0].objectId;
      await friend.delete();
    }
    setState(() {});
  }
}
