import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/shared_components/models/chat_model.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String senderId;
  final String receiverId;
  final ChatService chatService = ChatService();
  final TextEditingController messageController = TextEditingController();

  ChatScreen({
    required this.senderId,
    required this.receiverId,
  });

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      final message = ChatMessage(
        senderId: senderId,
        receiverId: receiverId,
        message: messageController.text,
        timestamp: DateTime.now(),
      );
      chatService.sendMessage(message);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: chatService.getMessages(senderId, receiverId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                final messages = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == senderId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                      child: Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: ChatBubble(
                          message: message.message,
                          isMe: isMe,
                        ),
                      ),
                    );
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
                    decoration: InputDecoration(labelText: 'Enter message'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.blueAccent : Colors.grey[300],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
          bottomLeft: isMe ? Radius.circular(12) : Radius.zero,
          bottomRight: isMe ? Radius.zero : Radius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: isMe ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
