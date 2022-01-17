import 'package:DIE/models/activity.dart';
import 'package:DIE/widgets/activity_page/activity_list.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

List<bool> selectedFav = List.generate(activities.length, (i) => false);
List? readedActivities = [];

class UserFavActList extends StatefulWidget {
  const UserFavActList({Key? key}) : super(key: key);

  @override
  _UserFavActListState createState() => _UserFavActListState();
}

class _UserFavActListState extends State<UserFavActList> {
  Future<List<Activity>> readActivities() async {
    if (readedActivities!.isNotEmpty || selectedFav.contains(true)) {
      return activities;
    }
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    QueryBuilder<ParseObject> queryUserPoints =
        QueryBuilder<ParseObject>(ParseObject('UserFavAct'))
          ..whereEqualTo('user', currentUser);
    final ParseResponse apiResponse = await queryUserPoints.query();
    List<ParseObject> objects = apiResponse.results as List<ParseObject>;
    readedActivities = objects[0].get<List>('activities');
    selectedFav = List.generate(activities.length, (i) => false);
    for (int i = 0; i < activities.length; i++) {
      if (readedActivities!.contains(activities[i].name)) {
        selectedFav[i] = true;
      }
    }
    return activities;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Activity>>(
      future: readActivities(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.8,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xff333333),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                ),
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
                            vertical: 1, horizontal: 4),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15),
                            child: Column(
                              children: [
                                ListTile(
                                  isThreeLine: false,
                                  leading: ImageIcon(
                                    AssetImage("assets/icons/" +
                                        snapshot.data![index].icon!),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  title: Text(snapshot.data![index].name!),
                                  trailing: IconButton(
                                      icon: selectedFav[index]
                                          ? ImageIcon(
                                              const AssetImage(
                                                  "assets/icons/heart.png"),
                                              color: Colors.amber[800],
                                              size: 30,
                                            )
                                          : const ImageIcon(
                                              AssetImage(
                                                  "assets/icons/heart.png"),
                                              color: Colors.white,
                                              size: 30),
                                      onPressed: () {
                                        setState(() {
                                          selectedFav[index] =
                                              !selectedFav[index];
                                        });
                                      }),
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
          return Column(
            children: const [
              SizedBox(
                height: 50,
              ),
              CircularProgressIndicator()
            ],
          );
        }
      },
    );
  }
}
