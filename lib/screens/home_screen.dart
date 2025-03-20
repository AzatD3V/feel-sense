import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xxx/image_processing.dart';
import 'package:xxx/model/tflite_model.dart';
import 'package:xxx/services/db_services.dart';
import 'package:xxx/services/together_ai_services.dart';
import 'package:xxx/widgets/ai_show.dart';
import 'package:xxx/widgets/clip_path.dart';
import 'package:xxx/widgets/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final EmotionDetector emotionDetector = EmotionDetector();
  final ImageProcessor imageProcessor = ImageProcessor();
  final TogetherAIService _service = TogetherAIService();
  final DBServices _services = DBServices();
  String detectedEmotion = "Not yet analyzed ";
  String aiResponse = "";
  bool isLoading = false;
  String aiThinking = "Hadi duygularini analiz et ve yolculuga basla";

  late AnimationController _contorller1;
  late AnimationController _controller2;
  late AnimationController _controller3;
  late AnimationController _controller4;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;
  late Animation<Offset> _animation3;
  late Animation<Offset> _animation4;
  @override
  void dispose() {
    _contorller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadModel();
    _contorller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _animation1 = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _contorller1, curve: Curves.easeOut));

    _contorller1.forward();

    _controller2 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation2 = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller2, curve: Curves.easeOut));
    _controller2.forward();

    _controller3 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation3 = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller3, curve: Curves.easeOut));
    _controller3.forward();

    _controller4 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation4 = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller4, curve: Curves.easeOut));
    _controller4.forward();
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
      aiResponse = "";
      setState(() {
        aiThinking =
            "Verilerini analiz ediyorum ve\n sana bir oneri hazirliyorum";
      });
      String prompt =
          "Kullanici $detectedEmotion hissediyor ona yardimci olacak onerini yap lutfen. Ve cevabin bir onceki cevap ile ayni olmasin";
      String response = await _service.getAIResponse(prompt);
      await _services.saveLastResponse(response);
      await _services.saveStatistics(getValue(detectedEmotion), response);

      setState(() {
        aiResponse = response;
      });
      await Future.wait([]);
    } catch (e) {
      detectedEmotion = "Error: ${e.toString()}";
    }
    return '';
  }

  double getValue(String emotion) {
    switch (emotion) {
      case "Üzgün":
        return 0;

      case "Öfke":
        return 1;

      case "Korku":
        return 2;

      case "Tiksinti":
        return 3;

      case "Nötr":
        return 4;

      case "Şaşkın":
        return 5;

      case "Mutlu":
        return 6;
      default:
        throw Exception("Gecersiz duygu $emotion");
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppbar(title: "Analysis"),
      body: Column(
        children: [
          SlideTransition(
            position: _animation4,
            child: ClipPath(
              clipper: OvalClipper(),
              child: Container(
                alignment: Alignment.center,
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          "Emotion: $detectedEmotion",
                          style: GoogleFonts.montserrat(
                              color: Colors.white, fontSize: 20),
                        ),
                ),
              ),
            ),
          ),
          SizedBox(height: 40),
          SlideTransition(
            position: _animation1,
            child: Align(
              alignment: Alignment.centerLeft,
              child: analyzeButton(
                  context,
                  'Analyze from Camera 📸 ',
                  () => analyzeImage(ImageSource.camera),
                  Icons.camera_alt_outlined,
                  false),
            ),
          ),
          SizedBox(height: 60),
          SlideTransition(
            position: _animation2,
            child: Align(
              alignment: Alignment.centerRight,
              child: analyzeButton(
                  context,
                  'Analyze from Gallery 🖼️ ',
                  () => analyzeImage(ImageSource.gallery),
                  Icons.photo_library_outlined,
                  true),
            ),
          ),
          Expanded(child: SizedBox()),
          SlideTransition(
            position: _animation3,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 350,
                  padding: EdgeInsets.all(12),
                  color: Colors.black,
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      if (aiResponse.isEmpty)
                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                aiThinking,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              AnimatedBoxes(),
                            ],
                          ),
                        ),
                      if (aiResponse.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText(aiResponse,
                                  speed: Duration(milliseconds: 10),
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Colors.white))
                            ],
                            repeatForever: false,
                            totalRepeatCount: 1,
                          ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 45,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          getResponse();
                        },
                        style: ElevatedButton.styleFrom(
                          maximumSize: Size(100, 50),
                          backgroundColor: Colors.black,
                        ),
                        child: FittedBox(
                          child: Text(
                            "Oneri al ",
                            style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      // ad container with border for decorations
                      Container(
                        width: 130,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              aiResponse = '';
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              maximumSize: Size(100, 50),
                              elevation: 0,
                              backgroundColor: Colors.black),
                          child: FittedBox(
                            child: Text(
                              "Oneriyi sil",
                              style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container analyzeButton(BuildContext context, String title,
      GestureTapCallback onTap, IconData icon, bool right) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 6, spreadRadius: 1)
        ],
        color: Colors.black,
        borderRadius: right
            ? BorderRadius.only(
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20))
            : BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),
          ),
          IconButton(
              onPressed: onTap,
              icon: Icon(
                icon,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
