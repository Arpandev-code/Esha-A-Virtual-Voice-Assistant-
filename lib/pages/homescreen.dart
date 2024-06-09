import 'dart:core';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:share/share.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:tts_ai/openai_service.dart';
import 'package:lottie/lottie.dart';
import 'package:tts_ai/pages/aboutdev.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void make() async {
  //   final result = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const AuthScreen()),
  //   );
  //   StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (ctx, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           // return const SplashScreen();
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => (const SplashScreen())),
  //           );
  //         }
  //         if (snapshot.hasData) {
  //           // return const ChatScreen();
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => (const ChatScreen())),
  //           );
  //         }
  //         return result;
  //       });
  // }

  final speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  String lastWord = '';
  String? generatedContent;
  String? generatedImageUrl;
  final OpenAIServices openAIServices = OpenAIServices();
  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(
        onResult: onSpeechResult, listenFor: const Duration(seconds: 10));
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWord = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},

      //   child: const Icon(Icons.mic),
      // ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: const Icon(
        //   Icons.info,
        //   color: Colors.black,
        // ),
        //leading: const Icon(Icons.menu, color: Colors.black),
        title: BounceInDown(
          child: const Column(
            children: [
              Text(
                'Esha',
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Cera Pro', fontSize: 26),
              ),
              // const Text(
              //   'Powred by OpenAI',
              //   style: TextStyle(
              //       color: Colors.black, fontFamily: 'Cera Pro', fontSize: 16),
              // )
            ],
          ),
        ),
        // leading: IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.menu,
        //       color: Colors.white,
        //     )),

        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        elevation: 20.0,
        width: 250,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 140, 223, 241)),
              accountName: const Text(
                "Esha",
                style: TextStyle(
                    fontFamily: 'Cera Pro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text(
                'help@iamarpandev.tech',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  fontSize: 16,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 120, 197, 218),
                child: Image.asset('assets/images/virtualAssistant.png'),
              ),
            ),
            ListTile(
              title: const Text(
                "About Dev",
                style: TextStyle(fontFamily: 'Cera Pro'),
              ),
              leading:
                  Lottie.asset('assets/images/dev.json', height: 50, width: 50),
              // leading: const Icon(Icons.notification_important_sharp),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                );
              },
            ),
            const Divider(
              height: 0.3,
            ),
            ListTile(
                title: const Text(
                  "Share",
                  style: TextStyle(fontFamily: 'Cera Pro'),
                ),
                leading: Lottie.asset('assets/images/arrow.json',
                    height: 50, width: 50),
                onTap: () {
                  Share.share(
                      'check out this Amazing Voice Helper App Esha, She can Answer questions!',
                      subject: 'Look what I made!');
                }),
            const Divider(
              height: 0.3,
            ),
            ListTile(
              title: const Text("Community",
                  style: TextStyle(fontFamily: 'Cera Pro')),
              leading: Lottie.asset('assets/images/news.json',
                  width: 50, height: 50),
              onTap: () {},
            ),
            const Divider(
              height: 0.3,
            ),
            ListTile(
              title: const Text("Rate App",
                  style: TextStyle(fontFamily: 'Cera Pro')),
              leading: Lottie.asset('assets/images/rating.json',
                  height: 50, width: 50),
            ),
            const Divider(
              height: 0.3,
            ),
            const Spacer(),
            const Divider(
              height: 0.5,
              color: Colors.grey,
            ),
            ListTile(
              title: const Text("Privacy policy",
                  style: TextStyle(fontFamily: 'Cera Pro', fontSize: 13)),
              leading: Lottie.asset('assets/images/privacy-policy.json',
                  width: 40, height: 40),
            ),
            const Divider(
              height: 0.3,
            ),
            ListTile(
              title: const Text("Contact Us",
                  style: TextStyle(fontFamily: 'Cera Pro', fontSize: 13)),
              leading: Lottie.asset('assets/images/contact-me.json',
                  width: 40, height: 40),
            ),
            const Divider(
              height: 0.3,
            ),
            const ListTile(
              title: Text("     Made with ❤️ by Arpandev",
                  style: TextStyle(fontFamily: 'Cera Pro', fontSize: 14)),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        //  BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics())
        // physics: const BouncingScrollPhysics(
        //     parent: AlwaysScrollableScrollPhysics()),
        child: Column(children: [
          // const SizedBox(
          //   height: 10,
          // ),
          ZoomIn(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/virtualAssistant.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FadeInRight(
            child: Visibility(
              visible: generatedImageUrl == null,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 40)
                    .copyWith(top: 30),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.circular(20)
                        .copyWith(topLeft: Radius.zero)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    generatedContent == null
                        ? 'Hi,How can i help you today?'
                        : generatedContent!,
                    style: TextStyle(
                        fontFamily: 'Cera Pro',
                        color: Colors.black,
                        fontSize: generatedContent == null ? 20 : 18),
                  ),
                ),
              ),
            ),
          ),
          if (generatedImageUrl != null)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(
                generatedImageUrl!,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Center(
                    child: Lottie.asset('assets/images/Crazy-ellipse.json'),
                  );
                },
              ),
            ),
          Visibility(
            visible: generatedContent == null && generatedImageUrl == null,
            child: Container(
              //color: Colors.amber,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                top: 10,
                left: 27,
              ),
              child: const Text(
                'Here is some features',
                style: TextStyle(fontFamily: 'Cera Pro', fontSize: 18),
              ),
            ),
          ),
          Visibility(
            visible: generatedContent == null && generatedImageUrl == null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(165, 231, 144, 1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: const Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ChatGPT',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cera Pro',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      'A smart way to stay organized & informed with ChatGPT',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          color: Color.fromRGBO(19, 61, 95, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: generatedContent == null && generatedImageUrl == null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(157, 202, 235, 1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: const Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Dall-E',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cera Pro',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      'Get inspired and creative with your personal assistant powered by Dall-E',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          color: Color.fromRGBO(19, 61, 95, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: generatedContent == null && generatedImageUrl == null,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(222, 175, 239, 1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: const Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Smart Voice Assistant',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cera Pro',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(
                      'Get the best of both worlds with a voice assistant powered by Dall-E & ChatGPT',
                      style: TextStyle(
                          fontFamily: 'Cera Pro',
                          color: Color.fromRGBO(19, 61, 95, 1)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () async {
          // if (await speechToText.hasPermission && speechToText.isNotListening) {
          //   await startListening();
          // } else if (speechToText.isListening) {
          //   final talk = openAIServices.isArtPromptAPI(lastWord);
          //   if(talk.)

          //   // await stopListening();
          //   await systemSpeak(talk as String);
          // } else {
          //   initSpeechToText();
          //   initTextToSpeech();
          // }
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            final speech = await openAIServices.isArtPromptAPI(lastWord);
            if (speech.contains('https')) {
              generatedImageUrl = speech;
              generatedContent = null;
              setState(() {});
            } else {
              generatedImageUrl = null;
              generatedContent = speech;
              setState(() {});
              await systemSpeak(speech);
            }
            // await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: Icon(
          speechToText.isListening ? Icons.stop : Icons.mic,
        ),
      ),
    );
  }
}
