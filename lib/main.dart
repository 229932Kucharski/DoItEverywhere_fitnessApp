import 'package:flutter/material.dart';
import 'package:die_app/pages/home_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:die_app/addidtional/fooderlich_theme.dart';
import 'package:die_app/back4app/login.dart';
import 'package:die_app/back4app/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const keyApplicationId = 'FiaCUd1Ky4H4mMP91ew12KCeYSIqqeoGWeWbeIHH';
  const keyClientKey = 'FKrJEfuMg0FzwNsOsljGz7nCfPBM66iPXu7uAFVr';
  const keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);
  runApp(const DieApp());
}

class DieApp extends StatelessWidget {
  const DieApp({Key? key}) : super(key: key);

  Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = FooderlichTheme.dark();
    return MaterialApp(
      theme: theme,
      title: 'DoIT Yourself',
      home: FutureBuilder<bool>(
          future: hasUserLogged(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting: // wyświetlanie kręcego się kółka
                return const Scaffold(
                  body: Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  ),
                );
              default:
                if (snapshot.hasData && snapshot.data!) {
                  return const HomePage();
                } else {
                  return const Login();
                }
            }
          }),
      routes: <String, WidgetBuilder>{
        '/signUp': (context) => SignUp(),
        '/login': (context) => const Login(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
