import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController userPrompt = TextEditingController();
  final List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();

  void chatBot() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyB6PqgEB9f6focNpYCXRNx-t_BWuczx4qs',
    );

    final prompt = userPrompt.text;
    setState(() {
      messages.add(Message(text: prompt, isUser: true));
    });
    userPrompt.clear();

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);
    String? userResponse = response.text;

    setState(() {
      messages.add(Message(text: userResponse ?? 'Error', isUser: false));
    });


    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse:
              false,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: message.isUser
                          ? Colors.white
                          : Colors.grey[
                      800],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomLeft:
                        message.isUser ? Radius.circular(15) : Radius.zero,
                        bottomRight:
                        message.isUser ? Radius.zero : Radius.circular(15),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: message.isUser
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
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
                    controller: userPrompt,
                    style: TextStyle(
                      color: Colors.white
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle:
                      TextStyle(color: Colors.grey[500]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor:
                      Colors.grey[900],

                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Colors.black),
                  onPressed: chatBot,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isUser;

  Message({required this.text, required this.isUser});
}
