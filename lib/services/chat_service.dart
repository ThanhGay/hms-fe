import 'package:android_hms/core/constants/api_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatService {
  late IO.Socket socket;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void connect(String conversationId) {
    socket = IO.io("${APIConstants.api}chatHub", <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();

    socket.onConnect((_) {
      print("Connected to server");
      socket.emit(
          'JoinRoom', conversationId); // Tham gia phòng chat (cuộc hội thoại)
    });

    socket.on("ReceiveMessage", (data) {
      print("New message received: ${data}");
    });
  }

  void sendMessage(String conversationId, String sender, String message) async {
    if (message.isEmpty) return;

    await firestore
        .collection(conversationId)
        .doc("message_${DateTime.now().millisecondsSinceEpoch.toString()}")
        .set({
      'Sender': sender,
      'Message': message,
      'TimeStamp': FieldValue.serverTimestamp(), // Thời gian tạo tin nhắn
      'isRead': false
    });
  }

  Stream<List<Map<String, dynamic>>> getMessages(String conversationId) {
    return firestore
        .collection(conversationId)
        .orderBy("TimeStamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Stream<int> getUnreadMessageCountStream(String conversationId) {
    return FirebaseFirestore.instance
        .collection(conversationId)
        .where('Sender', isEqualTo: "Receptionist")
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  void markMessagesAsRead(String conversationId) async {
    final firestore = FirebaseFirestore.instance;
    print("CONV: ${conversationId}");
    final querySnapshot = await firestore
        .collection(conversationId)
        .where('Sender', isEqualTo: "Receptionist")
        .where('isRead', isEqualTo: false)
        .get();

    for (var doc in querySnapshot.docs) {
      await firestore
          .collection(conversationId)
          .doc(doc.id)
          .update({'isRead': true});
    }
  }
}
