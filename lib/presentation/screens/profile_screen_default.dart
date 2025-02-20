import 'package:flutter/material.dart';

class ProfileDefault extends StatelessWidget {
  const ProfileDefault({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Column(
              children: [
                Text('Log in to start planning your next trip'),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: Size.fromWidth(200),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                Row(
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(
                        onPressed: () async {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Settings'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Accessibility'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.home_sharp),
                      title: Text('Learn about hosting'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text('Get help'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Term of Service'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('Privacy Policy'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text('Version 25.01')
              ],
            )
          ],
        ),
      ),
    );
  }
}
