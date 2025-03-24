import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xxx/data/models/user_model.dart';
import 'package:xxx/data/repositories/db_services.dart';

class TogetherAIService {
  final String apiKey =
      '882e2b009f136e4321849f695f69140ee406b562c9497a2e3c0da31a3d51e4f7'; // Together AI API Key
  final DBServices _services = DBServices();
  final List<String> variations = [
    "Approach this from a different perspective.",
    "Express this suggestion using different words.",
    "Offer a new point of view.",
    "Give a suggestion that will catch the user's interest."
  ];

  Future<String> getAIResponse(String prompt) async {
    const String apiUrl = "https://api.together.xyz/v1/chat/completions";
    String variationsPrompt = (variations..shuffle()).first;
    String content = await getInfo();
    final bodyData = jsonEncode({
      "model": "deepseek-ai/DeepSeek-V3",
      /*  "meta-llama/Llama-3.3-70B-Instruct-Turbo", */
      "messages": [
        {"role": "system", "content": content},
        {"role": "user", "content": "$variationsPrompt \n $prompt"}
      ],
      "max_tokens": 1000,
      // "temperature": 1.1,
      //"top_p": 0.8
    });

    print("🔍 Together AI API’ye istek gönderiliyor: $bodyData");

    try {
      final response = await http
          .post(
            Uri.parse(apiUrl),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $apiKey",
            },
            body: bodyData,
          )
          .timeout(Duration(seconds: 20));

      print("📩 API’den gelen yanıt: ${response.statusCode}");
      print("📩 API yanıt içeriği: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        print("❌ Together AI API Hatası: ${response.body}");
        return "Together AI'den hata alındı: ${response.body}";
      }
    } catch (e) {
      print("❌ HTTP isteğinde hata oluştu: $e");
      return "Bağlantı hatası!";
    }
  }

  Future<String> getInfo() async {
    try {
      UserModel user = await _services.getInfo();

      String userInfo = """
    User Information:
    Hobbies: ${user.hobbies.join(", ")}
    Music Style: ${user.musicStyle.join(",")}
    Personality Style: ${user.personalityStyle.join(",")}
    Previous suggestion: ${user.response}
    This time your suggestion should be different. Do not repeat the same words or sentence structures. Offer alternatives and be creative!
    """;

      final String content = """
You are an expert-level suggestion assistant. Below are some key details about the user:

$userInfo

Additionally, the user will provide an emotional analysis and share their future emotional state through the prompt. Your goal is to use the user's information but avoid repeating it directly. Instead, you should craft an encouraging response that feels natural and not easily identifiable as coming from the user's information.

Your response should not include any generic phrases. Focus on offering constructive alternatives that are more personalized, thoughtful, and helpful. Keep the response clear, polite, and professional. Make sure the user feels understood without being overwhelmed by too much detail. Avoid using Markdown formatting such as asterisks or other symbols for emphasis.

Please ensure that your reply is in the same language as the prompt.
""";

      return content;
    } catch (e) {
      throw Exception("getInfo Error");
    }
  }
}
