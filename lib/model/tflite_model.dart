import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:xxx/constant/constant_list.dart';

class EmotionDetector {
  Interpreter? interpreter;
  bool isModelLoaded = false;

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset('assets/emotion_model.tflite');
      interpreter!.allocateTensors();
      isModelLoaded = true;
    } catch (e) {
      isModelLoaded = false;
    }
  }

  String detectEmotion(List<List<List<List<double>>>> inputTensor) {
    if (!isModelLoaded || interpreter == null) {
      return "Model Yüklenmedi!";
    }

    try {
      var output = List.generate(1, (index) => List.filled(7, 0.0));

      interpreter!.run(inputTensor, output);

      int detectedIndex =
          output[0].indexOf(output[0].reduce((a, b) => a > b ? a : b));

      final emotions = ConstantList.emotions;

      if (detectedIndex < 0 || detectedIndex >= emotions.length) {
        return "Duygu Algılanamadı!";
      }

      return emotions[detectedIndex];
    } catch (e) {
      return "Tahmin Yapılamadı!";
    }
  }
}
