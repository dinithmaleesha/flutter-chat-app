import 'package:chat_app/features/chat_screen/widgets/chat_app_bar.dart';
import 'package:chat_app/features/chat_screen/widgets/chat_bubble.dart';
import 'package:chat_app/features/chat_screen/widgets/chat_screen_skeleton.dart';
import 'package:chat_app/features/chat_screen/widgets/send_text_field.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/shared_components/models/chat_model.dart';
import 'package:chat_app/shared_components/theme/color_pallet.dart';
import 'package:chat_app/shared_components/util/constants.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String senderId;
  final String receiverId;
  final ChatService chatService = ChatService();
  final TextEditingController messageController = TextEditingController();

  ChatScreen({
    required this.name,
    required this.senderId,
    required this.receiverId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    widget.messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (widget.messageController.text.isNotEmpty) {
      final message = ChatMessage(
        senderId: widget.senderId,
        receiverId: widget.receiverId,
        message: widget.messageController.text,
        timestamp: DateTime.now(),
      );
      widget.chatService.sendMessage(message);
      widget.messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallet.mainColor,
        title: ChatAppBar(name: widget.name),
        iconTheme: IconThemeData(
          color: ColorPallet.white,
        ),
      ),
      backgroundColor: ColorPallet.backgroundColor,
      body: Column(
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: ColorPallet.gray,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, color: ColorPallet.grayColor, size: 10),
                  SizedBox(width: 8),
                  Text(
                    Constants.privacy,
                    style: TextStyle(fontSize: 11, color: ColorPallet.grayColor),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ChatMessage>>(
              stream: widget.chatService.getMessages(widget.senderId, widget.receiverId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final messages = snapshot.data ?? [];
                if (messages.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });
                }
                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(bottom: 10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isMe = message.senderId == widget.senderId;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
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
          // Bottom bar
          Container(
            padding: EdgeInsets.all(10),
            color: ColorPallet.white,
            child: Row(
              children: [
                Expanded(
                  child: SendTextField(
                    controller: widget.messageController,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: ColorPallet.mainGradient,
                  ),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.send, color: ColorPallet.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

