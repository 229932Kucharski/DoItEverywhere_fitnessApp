import 'package:DIE/addidtional/globals.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:DIE/addidtional/globals.dart' as globals;

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/background/bg_01_2.png"),
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
                const SizedBox(
                  height: 16,
                ),
                const Center(
                  child: Text(
                    'Create an account',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'SourceCodePro',
                    ),
                  ),
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
                      labelText: 'Username'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'E-mail'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
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
                  height: 8,
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
                      onPressed: () => {
                            if (!globals.isRedundentClick(DateTime.now()))
                              {
                                doUserRegistration(),
                              }
                          }),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text("Success!"),
          content: Text("User was successfully created!"),
          actions: <Widget>[
            Text("OK"),
          ],
        );
      },
    );
  }

  Future<void> createUserPoints(ParseUser user) async {
    final todo = ParseObject('UserData')
      ..set('user', user)
      ..set('points', 50000)
      ..set('pointsUpdatedAt', DateTime.now());
    await todo.save();
  }

  Future<void> createUserFavAct(ParseUser user) async {
    final todo = ParseObject('UserFavAct')
      ..set('user', user)
      ..set('activities', []);
    await todo.save();
  }

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      showError(context, "Some fields are still empty");
      return;
    }

    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 1500),
          content: Text("You have signed up successfully")));
      Navigator.pop(context);
      await createUserPoints(user);
      await createUserFavAct(user);
    } else {
      showError(context, response.error!.message);
    }
  }
}
