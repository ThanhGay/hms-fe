import 'dart:convert';
import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/component/info_card.dart';
import 'package:android_hms/presentation/component/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserInformation? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('user');

    print('JSON Data: $jsonData');

    if (jsonData != null) {
      setState(() {
        userData = UserInformation.fromJson(jsonDecode(jsonData));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("hello profile");
    print(userData);

    if (userData == null) {
      return ProfileDefault();
    } else {
      return ProfileWithUser(user: userData!);
    }
  }
}

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
                          // Navigator.pushNamed(context, '/register');
                          final prefs = await SharedPreferences.getInstance();
                          String? jsonData = prefs.getString('user');
                          Map<String, dynamic> user =
                              json.decode(jsonData!); // Chuyển lại thành Map
                          print(
                              'Data ${user['firstName']} ${user['lastName']}');
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

class ProfileWithUser extends StatelessWidget {
  const ProfileWithUser({
    super.key,
    required this.user,
  });

  final UserInformation user;

  @override
  Widget build(BuildContext context) {
    void pending() {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Chức năng đang phát triển")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 50,
                backgroundImage:
                    NetworkImage('assets/images/default_avatar.png'),
              ),
              title: Text(
                user.lastName,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              subtitle: Text(
                'Show profile',
                style: TextStyle(color: Colors.grey.shade500),
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded),
            ),
            Divider(),
            Expanded(
              child: ListView(
                children: [
                  BuildSectionTitle(title: "Settings"),
                  ListTile(
                    leading: Icon(Icons.account_circle_outlined),
                    title: Text("Personal information"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.security_outlined),
                    title: Text("Login & security"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.payment_outlined),
                    title: Text("Payments and payouts"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.settings_accessibility),
                    title: Text("Accessibility"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.file_copy_outlined),
                    title: Text("Taxes"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.translate),
                    title: Text("Translation"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications_outlined),
                    title: Text("Notifications"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.lock_outline),
                    title: Text("Privacy and sharing"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.luggage_outlined),
                    title: Text("Travel for work"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  Divider(),
                  BuildSectionTitle(title: "Hosting"),
                  ListTile(
                    leading: Icon(Icons.home_outlined),
                    title: Text("List your space"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.home_max_rounded),
                    title: Text("Learn about hosting"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.event),
                    title: Text("Host an experience"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  Divider(),
                  BuildSectionTitle(title: "Support"),
                  ListTile(
                    leading: Icon(Icons.help_outline_sharp),
                    title: Text("Visit the Help Center"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.shield_outlined),
                    title: Text("Get help with a safety issue"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      'assets/icons/logo.svg',
                      width: 24,
                      height: 24,
                    ),
                    title: Text("How Hotel7 works"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text("Give us feedback"),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  Divider(),
                  BuildSectionTitle(title: "Legal"),
                  ListTile(
                    leading: Icon(Icons.menu_book_sharp),
                    title: Text('Terms of Service'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.menu_book_sharp),
                    title: Text('Privacy Policy'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  ListTile(
                    leading: Icon(Icons.menu_book_sharp),
                    title: Text('Open source licenses'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: pending,
                  ),
                  Divider(),
                  TextButton(
                      onPressed: pending,
                      child: Text(
                        'Log out',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            color: Colors.deepOrangeAccent),
                      )),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailProfile extends StatelessWidget {
  const DetailProfile({
    super.key,
    required this.user,
  });

  final UserInformation user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // CircleAvatar(
        //   radius: 50,
        //   backgroundImage: NetworkImage(user.avatarUrl),
        // ),
        SizedBox(height: 16),
        InfoCard(
          icon: Icons.person,
          title: "Họ và Tên",
          value: '${user.firstName} ${user.lastName}',
        ),
        InfoCard(icon: Icons.cake, title: "Tuổi", value: user.dateOfBirth),
        InfoCard(
            icon: Icons.location_on,
            title: "Địa chỉ",
            value: user.citizenIdentity),
        InfoCard(icon: Icons.email, title: "Email", value: user.phoneNumber),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Chức năng đang phát triển")),
            );
          },
          child: Text("Chỉnh sửa"),
        ),
      ],
    );
  }
}
