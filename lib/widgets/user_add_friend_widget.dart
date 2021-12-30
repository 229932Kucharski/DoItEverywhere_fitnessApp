import 'package:flutter/material.dart';

class UserAddFriendWidget extends StatefulWidget {
  const UserAddFriendWidget({Key? key}) : super(key: key);

  @override
  _UserAddFriendWidgetState createState() => _UserAddFriendWidgetState();
}

class _UserAddFriendWidgetState extends State<UserAddFriendWidget> {
  final controllerUsername = TextEditingController();

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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
