import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xxx/services/together_ai_services.dart';
import '../image_processing.dart';
import '../tflite_model.dart';

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
      aiResponse = "";
    });

    try {
      var inputTensor = await imageProcessor.processImage(context, source);
      String emotion = emotionDetector.detectEmotion(inputTensor);
      setState(() {
        detectedEmotion = emotion;
      });

      // AI'ya duygu analizi sonucunu gönder
      String prompt =
          "A person is feeling $emotion. Make a suggestion that will help him/her.";
      String response = await aiService.getAIResponse(prompt);
      setState(() {
        aiResponse = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        detectedEmotion = "Error: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D2926),
      appBar: AppBar(
        backgroundColor: Color(0xffed6f63),
        title: Text(
          "Sentiment analysis",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
        centerTitle: true,
      ),
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
                                  TextStyle(fontSize: 24, color: Colors.white)),
                          if (aiResponse.isNotEmpty)
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.black.withValues(alpha: 0.5)),
                                child: ListView(
                                  children: [
                                    Text("AI Suggest: $aiResponse",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
