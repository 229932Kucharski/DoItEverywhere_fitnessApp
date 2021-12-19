import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/background/bg_03.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: Color(0xFFFF9505),
                      child: CircleAvatar(
                        radius: 85,
                        backgroundImage: AssetImage('assets/users/avatar.png'),
                      ),
                    ),
                    Text(
                      'Your name',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'SourceCodePro',
                      ),
                    ),
                  ],
                ))));
  }
}
