import 'package:chat_app/shared_components/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(ChatMessage message) async {
    final chatId = _getChatId(message.senderId, message.receiverId);

    final chatDoc = firestore.collection('chats').doc(chatId);
    final chatExists = (await chatDoc.get()).exists;

    if (!chatExists) {
      await _createNewChatRoom(chatId, message.senderId, message.receiverId);
    }

    await chatDoc.collection('messages').add(message.toJson());
  }

  // create a new chat room
  Future<void> _createNewChatRoom(String chatId, String senderId, String receiverId) async {
    try {
      await firestore.collection('chats').doc(chatId).set({
        'participants': [senderId, receiverId],
        'lastMessage': '',
        'lastUpdated': FieldValue.serverTimestamp(),
      });
      print('New chat room created: $chatId');
    } catch (e) {
      print('Error creating chat room: $e');
    }
  }

  String _getChatId(String senderId, String receiverId) {
    return senderId.hashCode <= receiverId.hashCode
        ? '$senderId-$receiverId'
        : '$receiverId-$senderId';
  }

  // listen for new messages
  Stream<List<ChatMessage>> getMessages(String senderId, String receiverId) {
    final chatId = _getChatId(senderId, receiverId);

    return firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ChatMessage.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
