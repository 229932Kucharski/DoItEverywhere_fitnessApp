import 'dart:io';

import 'package:flutter/material.dart';
import 'package:die_app/addidtional/globals.dart' as globals;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserAvatarWidget extends StatefulWidget {
  const UserAvatarWidget({Key? key}) : super(key: key);

  @override
  _UserAvatarWidgetState createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  File? avatarFile;

  Future pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      avatarFile = imageTemp;
      await uploadAvatar();
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<ParseObject?> getAvatar() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> userData =
        QueryBuilder<ParseObject>(ParseObject("UserData"))
          ..whereEqualTo("user", currentUser);
    final ParseResponse apiResponse = await userData.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> usersData = apiResponse.results as List<ParseObject>;
      return usersData[0];
    }
    return null;
  }

  Future<bool> uploadAvatar() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserData'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserPoints.query();
    String? id;
    List<ParseObject> objects = apiResponse.results as List<ParseObject>;
    for (ParseObject object in objects) {
      id = object.objectId;
    }
    ParseFileBase? parseFile;
    parseFile = ParseFile(File(avatarFile!.path));
    await parseFile.save();
    final userData = ParseObject('UserData')
      ..objectId = id
      ..set('avatar', parseFile);
    await userData.save();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0),
      child: SizedBox(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              GestureDetector(
                onLongPress: () => {
                  pickImage(),
                },
                child: FutureBuilder<ParseObject?>(
                  future: getAvatar(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        ParseFileBase? varFile =
                            snapshot.data?.get<ParseFileBase>('avatar');
                        if (varFile == null) {
                          return const CircleAvatar(
                            radius: 90,
                            backgroundColor: Color(0xFFFF9505),
                            child: CircleAvatar(
                                radius: 85,
                                backgroundImage:
                                    AssetImage('assets/users/avatar.png')),
                          );
                        } else {
                          return CircleAvatar(
                            radius: 90,
                            backgroundColor: const Color(0xFFFF9505),
                            child: CircleAvatar(
                              radius: 85,
                              backgroundImage: Image.network(
                                varFile!.url!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.fitHeight,
                              ).image,
                            ),
                          );
                        }
                      }
                    }
                    return Column(children: const [
                      SizedBox(
                        height: 130,
                      ),
                      CircularProgressIndicator(),
                    ]);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  "Hello ${globals.username}!",
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'SourceCodePro',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
