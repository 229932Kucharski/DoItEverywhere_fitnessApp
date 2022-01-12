import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserDataSettingsWidget extends StatefulWidget {
  const UserDataSettingsWidget({Key? key}) : super(key: key);

  @override
  _UserDataSettingsWidgetState createState() => _UserDataSettingsWidgetState();
}

class _UserDataSettingsWidgetState extends State<UserDataSettingsWidget> {
  final controllerHeight = TextEditingController();
  final controllerWeight = TextEditingController();
  final controllerAge = TextEditingController();

  ParseUser? currentUser;
  int? height = 180;
  int? weight = 70;
  int? age = 20;

  Future<ParseUser?> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser?;
    return currentUser;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> updateUser() async {
    await getUser();
    String? id;
    int? currentHeight;
    int? currentWeight;
    int? currentAge;

    if (controllerHeight.text != '') height = int.parse(controllerHeight.text);
    if (controllerWeight.text != '') weight = int.parse(controllerWeight.text);
    if (controllerAge.text != '') age = int.parse(controllerAge.text);

    QueryBuilder<ParseObject> queryUserData =
        QueryBuilder<ParseObject>(ParseObject('UserData'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserData.query();
    if (apiResponse.success && apiResponse.results != null) {
      List<ParseObject> objects = apiResponse.results as List<ParseObject>;
      for (ParseObject object in objects) {
        id = object.objectId;
        currentHeight = object.get('height');
        currentWeight = object.get('weight');
        currentAge = object.get('age');
      }
      currentHeight = height;
      currentWeight = weight;
      currentAge = age;
      var user = ParseObject('UserData')
        ..objectId = id
        ..set('height', currentHeight)
        ..set('weight', currentWeight)
        ..set('age', currentAge);
      await user.save();
    }
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
              TextField(
                controller: controllerHeight,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Height'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: controllerWeight,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Weight'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: controllerAge,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.none,
                autocorrect: false,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    labelText: 'Age'),
              ),
              SizedBox(
                height: 50,
                child: TextButton(
                  child: const Text(
                    'ACCEPT',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'SourceCodePro',
                      color: Color(0xFFFF9505),
                    ),
                  ),
                  onPressed: () async {
                    await updateUser();
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
