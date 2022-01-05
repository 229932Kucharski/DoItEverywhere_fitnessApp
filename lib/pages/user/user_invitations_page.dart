import 'package:die_app/widgets/user_page/user_invitations_widget.dart';
import 'package:flutter/material.dart';

class UserInvitationsPage extends StatelessWidget {
  const UserInvitationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/bg_01_2.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // part with avatar //
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 20.0),
                            child: Text(
                              "Manage your invitations",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'SourceCodePro',
                              ),
                            ),
                          ),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.groups, size: 60),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    const CircleBorder()),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(40)),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.deepPurple[800]), // <-- Button color
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return Colors.amber[800];
                                    } // <-- Splash color
                                  },
                                ),
                              ),
                            ),
                          ),
                          const UserInvitationWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
