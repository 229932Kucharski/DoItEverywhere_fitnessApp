import 'package:DIE/addidtional/globals.dart';
import 'package:DIE/addidtional/route_to_down.dart';
import 'package:DIE/addidtional/route_to_up.dart';
import 'package:DIE/back4app/sign_up.dart';
import 'package:DIE/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:DIE/addidtional/globals.dart' as globals;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background/bg_01_1.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: Image.asset(
                    'assets/logo/die.png',
                    scale: 0.5,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controllerUsername,
                  enabled: !isLoggedIn,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Username'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
                  enabled: !isLoggedIn,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Password'),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 50,
                  child: TextButton(
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'SourceCodePro',
                          color: Color(0xFFFF9505),
                        ),
                      ),
                      onPressed: isLoggedIn
                          ? null
                          : () => {
                                if (!globals.isRedundentClick(DateTime.now()))
                                  {
                                    doUserLogin(),
                                  }
                              }),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 50,
                  child: TextButton(
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SourceCodePro',
                        color: Color(0xFFFF9505),
                      ),
                    ),
                    onPressed: () {
                      if (!globals.isRedundentClick(DateTime.now())) {
                        Navigator.push(
                            context,
                            RouteToDown(
                                exitPage: const Login(),
                                enterPage: const SignUp()));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showError(context, "Some fields are still empty");
      return;
    }

    final user = ParseUser(username, password, null);
    var response = await user.login();

    if (response.success) {
      ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
      globals.username = currentUser?.username;
      globals.registerDate = currentUser?.createdAt;
      Navigator.push(context,
          RouteToUp(exitPage: const Login(), enterPage: const HomePage()));
    } else {
      showError(context,
          response.error!.message + " Also check your Internet connection");
    }
  }
}
