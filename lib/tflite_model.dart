import 'package:tflite_flutter/tflite_flutter.dart';

class EmotionDetector {
  Interpreter? interpreter;
  bool isModelLoaded = false;

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/emotion_model.tflite');
      interpreter!.allocateTensors();
      isModelLoaded = true;
      print("✅ Model başarıyla yüklendi!");
    } catch (e) {
      print("❌ Model yüklenirken hata oluştu: $e");
      isModelLoaded = false;
    }
  }

  String detectEmotion(List<List<List<List<double>>>> inputTensor) {
    if (!isModelLoaded || interpreter == null) {
      print("❌ Model yüklenmedi, `loadModel()` çağrılmalı!");

      return "Model Yüklenmedi!";
    }

    try {
      var output = List.generate(1, (index) => List.filled(7, 0.0));

      print("🧠 Model çalıştırılıyor...");
      interpreter!.run(inputTensor, output);
      print("✅ Model başarıyla çalıştırıldı. Çıktı: $output");

      int detectedIndex =
          output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));

      List<String> emotions = [
        "Öfke",
        "Tiksinti",
        "Korku",
        "Mutlu",
        "Üzgün",
        "Şaşkın",
        "Nötr"
      ];

      if (detectedIndex < 0 || detectedIndex >= emotions.length) {
        print("❌ Geçersiz duygu tahmini index: $detectedIndex");
        return "Duygu Algılanamadı!";
      }

      print("🔍 Algılanan Duygu: ${emotions[detectedIndex]}");
      return emotions[detectedIndex];
    } catch (e) {
      print("❌ Model çalıştırılırken hata oluştu: $e");
      return "Tahmin Yapılamadı!";
    }
  }
}
