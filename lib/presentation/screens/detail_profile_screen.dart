import 'package:flutter/material.dart';
import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/utils/toast.dart';
import 'package:android_hms/presentation/component/info_card.dart';

class DetailProfile extends StatefulWidget {
  const DetailProfile({
    super.key,
    required this.user,
  });

  final UserInformation user;

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(isEdit ? "Chỉnh sửa thông tin cá nhân" : "Thông tin cá nhân"),
      ),
      body: isEdit ? _editUser() : _displayInfoUser(),
    );
  }

  Widget _displayInfoUser() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
            value: '${widget.user.firstName} ${widget.user.lastName}',
          ),
          InfoCard(
              icon: Icons.cake,
              title: "Tuổi",
              value: (DateTime.now().year - widget.user.dateOfBirth.year)
                  .toString()),
          InfoCard(
              icon: Icons.location_on,
              title: "Địa chỉ",
              value: widget.user.citizenIdentity),
          InfoCard(
              icon: Icons.phone,
              title: "Số điện thoại",
              value: widget.user.phoneNumber),
          InfoCard(
              icon: Icons.credit_card,
              title: "CCCD",
              value: widget.user.citizenIdentity),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isEdit = true;
              });

              showToast(
                  msg: ("Chức năng đang phát triển"),
                  backgroundColor: Colors.orange,
                  textColor: Colors.white);
            },
            child: Text("Chỉnh sửa"),
          ),
        ],
      ),
    );
  }

  Widget _editUser() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Chỉnh sửa'),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  isEdit = false;
                });
              },
              child: Text('Lưu'))
        ],
      ),
    );
  }
}
