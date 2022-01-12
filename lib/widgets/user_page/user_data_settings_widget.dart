import 'package:flutter/material.dart';

class UserDataSettingsWidget extends StatefulWidget {
  const UserDataSettingsWidget({Key? key}) : super(key: key);

  @override
  _UserDataSettingsWidgetState createState() => _UserDataSettingsWidgetState();
}

class _UserDataSettingsWidgetState extends State<UserDataSettingsWidget> {
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
              TextField(
                controller: controllerUsername,
                keyboardType: TextInputType.text,
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
                controller: controllerUsername,
                keyboardType: TextInputType.text,
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
                controller: controllerUsername,
                keyboardType: TextInputType.text,
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
