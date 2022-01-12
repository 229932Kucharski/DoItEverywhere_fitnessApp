import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:die_app/addidtional/globals.dart' as globals;

class UserAddFriendWidget extends StatefulWidget {
  const UserAddFriendWidget({Key? key}) : super(key: key);

  @override
  _UserAddFriendWidgetState createState() => _UserAddFriendWidgetState();
}

class _UserAddFriendWidgetState extends State<UserAddFriendWidget> {
  final controllerUsername = TextEditingController();

  Future<ParseObject?> findUser(String username) async {
    QueryBuilder<ParseObject> queryUsers =
        QueryBuilder<ParseObject>(ParseUser.forQuery())
          ..whereEqualTo('username', username);
    final ParseResponse apiResponse = await queryUsers.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> objects = apiResponse.results as List<ParseObject>;
      // ignore: unnecessary_null_comparison
      if (objects == null) {
        return null;
      }
      return objects[0];
    }
    return null;
  }

  Future<bool> checkIfInviteAlreadyExists(
      ParseObject user, ParseUser currentUser) async {
    QueryBuilder<ParseObject> queryInvites =
        QueryBuilder<ParseObject>(ParseObject('UserInvites'))
          ..whereEqualTo('user', user)
          ..whereEqualTo('inviteFrom', currentUser);
    final ParseResponse apiResponse = await queryInvites.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> objects = apiResponse.results as List<ParseObject>;
      // ignore: unnecessary_null_comparison
      if (objects == null) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<bool> checkIfUserIsAFriendAlready(
      ParseObject user, ParseUser currentUser) async {
    QueryBuilder<ParseObject> queryInvites =
        QueryBuilder<ParseObject>(ParseObject('UserFriends'))
          ..whereEqualTo('user', currentUser)
          ..whereEqualTo('friend', user);
    final ParseResponse apiResponse = await queryInvites.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> objects = apiResponse.results as List<ParseObject>;
      // ignore: unnecessary_null_comparison
      if (objects == null) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  Future<void> inviteUser(ParseObject user) async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser!.get('username') == user.get('username')) {
      return;
    }
    if (await checkIfInviteAlreadyExists(user, currentUser)) {
      return;
    }
    if (await checkIfUserIsAFriendAlready(user, currentUser)) {
      return;
    }
    final userInvites = ParseObject('UserInvites')
      ..set('user', user)
      ..set('inviteFrom', currentUser);
    await userInvites.save();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: controllerUsername,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Friend username'),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SourceCodePro',
                      color: Color(0xFFFF9505),
                    ),
                  ),
                  onPressed: () async {
                    if (!globals.isRedundentClick(DateTime.now())) {
                      ParseObject? user =
                          await findUser(controllerUsername.text);
                      if (user == null) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(milliseconds: 1500),
                                content: Text("No user found")));
                      } else {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(milliseconds: 1500),
                                content: Text("The user has been invited")));
                        await inviteUser(user);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
