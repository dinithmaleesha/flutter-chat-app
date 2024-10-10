import 'package:chat_app/shared_components/models/chat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Function to send a message and create a new chat room if it doesn't exist
  Future<void> sendMessage(ChatMessage message) async {
    final chatId = _getChatId(message.senderId, message.receiverId);

    // Check if chat room exists
    final chatDoc = firestore.collection('chats').doc(chatId);
    final chatExists = (await chatDoc.get()).exists;

    if (!chatExists) {
      // If the chat doesn't exist, create a new chat room
      await _createNewChatRoom(chatId, message.senderId, message.receiverId);
    }

    // Save message in the chat room's messages sub-collection
    await chatDoc.collection('messages').add(message.toJson());
  }

  // Function to create a new chat room
  Future<void> _createNewChatRoom(String chatId, String senderId, String receiverId) async {
    try {
      await firestore.collection('chats').doc(chatId).set({
        'participants': [senderId, receiverId], // Store participants
        'lastMessage': '', // This can be updated with the last sent message
        'lastUpdated': FieldValue.serverTimestamp(), // Timestamp of last activity
      });
      print('New chat room created: $chatId');
    } catch (e) {
      print('Error creating chat room: $e');
    }
  }

  // Function to get a unique chat ID for a chat between two users
  String _getChatId(String senderId, String receiverId) {
    return senderId.hashCode <= receiverId.hashCode
        ? '$senderId-$receiverId'
        : '$receiverId-$senderId';
  }

  // Function to listen for new messages
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
