import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tts_ai/key.dart';

class OpenAIServices {
  final List<Map<String, String>> messsages =
      []; // this list storing the messages
  Future<String> isArtPromptAPI(String prompt) async {
    //it will tell system if user want to genarte images in yes or no formate
    try {
      final res = await http.post(
          Uri.parse(
              'https://api.openai.com/v1/chat/completions'), //calling http post request. response stores in res
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAIAPIKeY',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content":
                    "Does this message want to generate an AI picture,image,art or anything similar? $prompt . Simply answer with yes or no."
              }
            ]
          }));
      //  print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return 'An Internal Error Occourred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    //it's the main chatgpt
    messsages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAIAPIKeY',
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": messsages,
          }));
      //  print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messsages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An Internal Error Occourred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> dallEAPI(String prompt) async {
    //it will create art or image
    messsages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/images/generations'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAIAPIKeY',
          },
          body: jsonEncode({
            'prompt': prompt,
            'n': 1,
          }));
      print(res.body);
      if (res.statusCode == 200) {
        String imageURL = jsonDecode(res.body)['data'][0]['url'];
        imageURL = imageURL.trim();
        messsages.add({
          'role': 'assistant',
          'content': imageURL,
        });
        return imageURL;
      }
      return 'An Internal Error Occourred';
    } catch (e) {
      return e.toString();
    }
  }
}
