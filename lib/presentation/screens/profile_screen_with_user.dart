import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/core/constants/default.dart';
import 'package:android_hms/core/services/Auth/api_logout.dart';

import 'package:android_hms/presentation/utils/toast.dart';
import 'package:android_hms/presentation/component/section_title.dart';
import 'package:android_hms/presentation/screens/detail_profile_screen.dart';

class ProfileWithUser extends StatelessWidget {
  final UserInformation user;
  const ProfileWithUser({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    void pending() {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Chức năng đang phát triển")),
      // );
      showToast(
          msg: ("Chức năng đang phát triển"),
          backgroundColor: Colors.orange[400],
          textColor: Colors.white);
    }

    Future<void> logoutUser(BuildContext context) async {
      bool confirm = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Warning"),
              content: Text("Are you sure to log out ?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("Logout"),
                ),
              ],
            ),
          ) ??
          false;

      if (confirm) {
        final statusCode = await ApiLogout.logoutUser();

        if (statusCode == "Success") {
          showToast(
              msg: ("Đăng xuất thành công!"),
              backgroundColor: Colors.green[400],
              textColor: Colors.white);

          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
          });
        } else {
          showToast(
              msg: ("Đăng xuất thất bại! Vui lòng thử lại."),
              backgroundColor: Colors.orange[400],
              textColor: Colors.white);
        }
      }
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
                      AssetImage(DefaultConstants.defaultAvatarUser),
                ),
                title: Text(
                  user.lastName,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                subtitle: Text(
                  'Xem chi tiết',
                  style: TextStyle(color: Colors.grey.shade500),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  // hiển thị màn hình Detail Profile
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailProfile(user: user),
                    ),
                  );
                }),
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
                      onPressed: () {
                        logoutUser(context);
                      },
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
