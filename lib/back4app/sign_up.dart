import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 16,
              ),
              const Center(
                child:
                    Text('Create an account', style: TextStyle(fontSize: 16)),
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
                  child: const Text('SIGN UP'),
                  onPressed: () => doUserRegistration(),
                ),
              )
            ],
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

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: const <Widget>[
            Text("OK"),
          ],
        );
      },
    );
  }

  Future<void> createUserPoints(ParseUser user) async {
    final todo = ParseObject('UserData')
      ..set('user', user)
      ..set('points', 50000);
    await todo.save();
  }

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      await createUserPoints(user);
      Navigator.pop(context);
    } else {
      showError(response.error!.message);
    }
  }
}
