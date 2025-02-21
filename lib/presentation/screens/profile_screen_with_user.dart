import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/component/section_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileWithUser extends StatelessWidget {
  final UserInformation user;
  const ProfileWithUser({
    super.key,
    required this.user,
  });

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

// class DetailProfile extends StatelessWidget {
//   const DetailProfile({
//     super.key,
//     required this.user,
//   });

//   final UserInformation user;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         // CircleAvatar(
//         //   radius: 50,
//         //   backgroundImage: NetworkImage(user.avatarUrl),
//         // ),
//         SizedBox(height: 16),
//         InfoCard(
//           icon: Icons.person,
//           title: "Họ và Tên",
//           value: '${user.firstName} ${user.lastName}',
//         ),
//         InfoCard(icon: Icons.cake, title: "Tuổi", value: user.dateOfBirth),
//         InfoCard(
//             icon: Icons.location_on,
//             title: "Địa chỉ",
//             value: user.citizenIdentity),
//         InfoCard(icon: Icons.email, title: "Email", value: user.phoneNumber),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: () {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("Chức năng đang phát triển")),
//             );
//           },
//           child: Text("Chỉnh sửa"),
//         ),
//       ],
//     );
//   }
// }
