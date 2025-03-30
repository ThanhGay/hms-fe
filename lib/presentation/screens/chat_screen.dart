import 'dart:convert';

import 'package:android_hms/Entity/user.dart';
import 'package:android_hms/presentation/component/chat_service.dart';
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
  @override
  void initState() {
    super.initState();

    SetConversationId();
    print("chat screen :${conversationId}");
  }

  Future<void> SetConversationId() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('user');

    if (jsonData != null) {
      setState(() {
        conversationId =
            "receptionist-${UserInformation.fromJson(jsonDecode(jsonData)).userId}";
        print("COncer: ${conversationId}");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat App")),
      body: Column(
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
                        ? DateFormat('yyyy-MM-dd HH:mm')
                            .format((msg['TimeStamp'] as Timestamp).toDate())
                        : 'Không xác định';

                    return Align(
                        alignment: sender == "Receptionist"
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          margin:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 8),
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
      ),
    );
  }
}
