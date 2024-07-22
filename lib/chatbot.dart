import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final TextEditingController userPrompt = TextEditingController();

  String res ="";


  void chatBot()async{

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyB6PqgEB9f6focNpYCXRNx-t_BWuczx4qs',
    );

    final prompt = userPrompt.text;
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    debugPrint(response.text);

    String? userResponse = response.text;

    setState(() {
      res = userResponse!;
    });

    userPrompt.clear();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(
                width: 250,
                child: TextFormField(
                  controller: userPrompt,
                  decoration: const InputDecoration(
                      hintText: "Write something",
                      border: OutlineInputBorder()
                  ),
                )),

            const SizedBox(height: 10,),

            ElevatedButton(onPressed: (){
              chatBot();
            }, child: const Text("Generate")),

            const SizedBox(height: 10,),

            Text(res)

          ],

        ),
      ),

    );
  }
}