import 'package:flutter/material.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarCustom({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Container(
          child: Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
            size: 40, // Chỉnh kích thước icon
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/home',
            arguments: {"initialTabIndex": 0},
          ); // quay lại trang trước
        },
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Text(title,
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600)),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
