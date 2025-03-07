import 'dart:convert';
import 'package:http/http.dart' as http;

class TogetherAIService {
  final String apiKey =
      '882e2b009f136e4321849f695f69140ee406b562c9497a2e3c0da31a3d51e4f7'; // Together AI'den aldığın API anahtarını buraya ekle.

  Future<String> getAIResponse(String prompt) async {
    const String apiUrl = "https://api.together.xyz/v1/chat/completions";

    final bodyData = jsonEncode({
      "model":
          "meta-llama/Llama-3.3-70B-Instruct-Turbo", // Ücretsiz kullanabileceğin modellerden biri
      "messages": [
        {"role": "system", "content": "Sen bir öneri asistanısın."},
        {"role": "user", "content": prompt}
      ],
      "max_tokens": 500,
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
          .timeout(Duration(seconds: 10));

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
}
