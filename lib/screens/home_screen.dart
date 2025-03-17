import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xxx/services/together_ai_services.dart';
import 'package:xxx/widgets/custom_appbar.dart';
import '../image_processing.dart';
import '../model/tflite_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final EmotionDetector emotionDetector = EmotionDetector();
  final ImageProcessor imageProcessor = ImageProcessor();
  final TogetherAIService aiService = TogetherAIService();

  String detectedEmotion = "Not yet analyzed ";
  String aiResponse = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void loadModel() async {
    await emotionDetector.loadModel();
    setState(() {});
  }

  void analyzeImage(ImageSource source) async {
    setState(() {
      isLoading = true;
    });

    try {
      var inputTensor = await imageProcessor.processImage(context, source);
      String emotion = emotionDetector.detectEmotion(inputTensor);
      setState(() {
        detectedEmotion = emotion;
      });

      // AI'ya duygu analizi sonucunu gönder

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        detectedEmotion = "Error: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  Future<String> getResponse() async {
    try {
      String prompt =
          "Kullanici $detectedEmotion hissediyor ona yardimci olacak onerini yap lutfen.";
      String response = await aiService.getAIResponse(prompt);
      setState(() {
        aiResponse = response;
      });
    } catch (e) {
      detectedEmotion = "Error: ${e.toString()}";
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "Analysis"),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Text("Emotion: $detectedEmotion",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.black)),
                        ],
                      ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () => analyzeImage(ImageSource.camera),
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 3),
                        color: Colors.black.withValues(alpha: 0.6)),
                    child: Text(
                      'Analyze from Camera 📸 ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => analyzeImage(ImageSource.gallery),
                  child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 3),
                        color: Colors.black.withValues(alpha: 0.6)),
                    child: Text(
                      'Analyze from Gallery 🖼️ ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      getResponse();
                    },
                    child: Text("Oneri al ")),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.black),
                    child: ListView(
                      children: [
                        if (aiResponse.isNotEmpty)
                          AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(aiResponse,
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Colors.white))
                            ],
                            repeatForever: false,
                          ),
                      ],
                    ),
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
