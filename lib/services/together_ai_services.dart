import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xxx/model/user_model.dart';
import 'package:xxx/services/db_services.dart';

class TogetherAIService {
  final String apiKey =
      '882e2b009f136e4321849f695f69140ee406b562c9497a2e3c0da31a3d51e4f7'; // Together AI'den aldığın API anahtarını buraya ekle.
  final DBServices _services = DBServices();

  Future<String> getAIResponse(String prompt) async {
    const String apiUrl = "https://api.together.xyz/v1/chat/completions";
    UserModel user = await _services.getInfo();
    String userInfo = """
    Kullanici bilgileri:
    Hobileri: ${user.hobbies.join(", ")}
    Muzik Tarzı: ${user.musicStyle.join(",")}
    Kisilik Tarzi: ${user.personalityStyle.join(",")}
    Lutfen bu bilgileri kullanarak fakat kullaniciyi rahatsiz edecek duzeyde tum bilgileri acikca kullanma sadece yonlendirme yap.
    """;

    final String content =
        """ Sen cok uzman seviyede analizci bir oneri asistanisin alt satirda kullaniciya ait bazi bilgiler yer almakta
      $userInfo 
      bununla birlikte kullanici sana ruh hali analizi yaparak gelecek ruh halini sana prompt icersinde verecek, 
      senin amacin kullaniciya ait bilgileri kullanarak fakat bu bilgileri dogrudan kullaniciya tekrar etmek yerine tesfik edici sekilde ve 
      onun bilgilerini okudugun anlasilmayacak sekilde bulunmalisin, rahatsiz etmeyecek duzeyde uzun bir mesaj yazmalisin gecistirici cevaplar 
      yerine daha yapici ve alternatifler iceren bir cevap vermelisin.
      """;
    final bodyData = jsonEncode({
      "model":
          "meta-llama/Llama-3.3-70B-Instruct-Turbo", // Ücretsiz kullanabileceğin modellerden biri
      "messages": [
        {"role": "system", "content": content},
        {"role": "user", "content": prompt}
      ],
      "max_tokens": 1000,
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
}
