import 'dart:convert';

import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/component/appbar_custom.dart';
import 'package:android_hms/core/services/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final ChatService chatService = ChatService();
  final TextEditingController messageController = TextEditingController();
  String conversationId = "Receptionist";
  bool isLoggedIn = false;
  @override
  void initState() {
    super.initState();
    checkLogin();
    SetConversationId();
    makeAsSend();
  }

  Future<void> makeAsSend() async {
    final prefs = await SharedPreferences.getInstance();
    String? convId = prefs.getString('conversationId');
    chatService.markMessagesAsRead(convId!);
  }

  Future<void> SetConversationId() async {
    final prefs = await SharedPreferences.getInstance();
    String? convId = prefs.getString('conversationId');

    if (convId != null) {
      setState(() {
        conversationId = convId;
      });
      // Kiểm tra nếu conversationId không phải là rỗng
      if (conversationId.isNotEmpty) {
        chatService.connect(conversationId);
      } else {
        print("Lỗi: conversationId bị rỗng");
      }
    } else {
      print("Lỗi: Không tìm thấy dữ liệu user trong SharedPreferences");
    }
  }

  void sendMessage() async {
    String message = messageController.text;
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('user');
    UserInformation userData = UserInformation.fromJson(jsonDecode(jsonData!));
    print("${message}");
    if (message.isNotEmpty) {
      chatService.sendMessage(
          conversationId, userData.firstName + userData.lastName, message);
      messageController.clear();
    }
  }

  Future<void> checkLogin() async {
    // Ví dụ: lấy token từ SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // hoặc từ Provider
    if (token != null && token.isNotEmpty) {
      setState(() {
        isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCustom(title: "Chăm sóc khách hàng"),
      body: isLoggedIn
          ? Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<Map<String, dynamic>>>(
                    stream: chatService.getMessages(conversationId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Text("Lỗi: ${snapshot.error}");
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text("Chưa có tin nhắn nào"));
                      }

                      var messages = snapshot.data!;
                      return ListView.builder(
                        reverse: true, // Hiển thị tin nhắn mới nhất ở dưới cùng
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          var msg = messages[index];
                          var sender = msg['Sender'] ?? 'Không rõ';
                          var message = msg['Message'] ?? '';
                          var timestamp = msg['TimeStamp'] != null
                              ? DateFormat('yyyy-MM-dd HH:mm').format(
                                  (msg['TimeStamp'] as Timestamp).toDate())
                              : 'Không xác định';

                          return Align(
                              alignment: sender == "Receptionist"
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                margin: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: sender == "Receptionist"
                                      ? Colors.grey[300]
                                      : Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(12),
                                    bottomLeft: sender == "Receptionist"
                                        ? Radius.circular(0)
                                        : Radius.circular(12),
                                    bottomRight: sender == "Receptionist"
                                        ? Radius.circular(12)
                                        : Radius.circular(0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message,
                                      style: TextStyle(
                                        color: sender == "Receptionist"
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      timestamp,
                                      style: TextStyle(
                                        color: sender == "Receptionist"
                                            ? Colors.black54
                                            : Colors.white70,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: "Nhập tin nhắn...",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: sendMessage,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa đăng nhập!",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (isLoggedIn) {
                        // Chuyển sang trang khám phá
                        Navigator.pushNamed(
                          context,
                          '/home',
                          arguments: {"initialTabIndex": 0},
                        ); // Thay bằng route đúng
                      } else {
                        // Chuyển sang trang đăng nhập
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: Text(isLoggedIn ? "Khám phá" : "Đăng nhập"),
                  ),
                ],
              ),
            ),
    );
  }
}
