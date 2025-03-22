import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xxx/screens/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  CameraDescription? _camera;
  ResolutionPreset? _resolutionPreset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: IntroductionScreen(
        globalBackgroundColor: Colors.white,
        key: _introKey,
        pages: [firstPage(), secondPage(), pageThree()],
        skip: Text(
          'skip'.tr(),
          style: buttonTextStyle(),
        ),
        onSkip: onSkipOrDone,
        next: Icon(
          Icons.arrow_forward_ios,
        ),
        done: Text(
          'done'.tr(),
          style: buttonTextStyle(),
        ),
        onDone: onSkipOrDone,
        back: Icon(Icons.arrow_back_ios),
        showSkipButton: true,
        showNextButton: true,
        showDoneButton: true,
        showBackButton: true,
        skipStyle: skipButtonStyle(),
        nextStyle: backNextButtonStyle(),
        doneStyle: doneButtonStyle(),
        backStyle: backNextButtonStyle(),
        dotsDecorator: dotsDecorator(),
      ),
    );
  }

  PageViewModel pageThree() {
    return PageViewModel(
        image: lastImage(),
        titleWidget: Text(
          "here_for_u".tr(),
          style: welcomeStyle(),
        ),
        bodyWidget: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text(
            textAlign: TextAlign.center,
            "descp2".tr(),
            style: descripStyle(),
          ),
        ));
  }

  SizedBox lastImage() {
    return SizedBox(
      height: 400,
      width: 500,
      child: Image.asset(
        "assets/11.jpg",
        fit: BoxFit.contain,
      ),
    );
  }

  PageViewModel secondPage() {
    return PageViewModel(
        image: secondImage(),
        titleWidget: Text(
          textAlign: TextAlign.center,
          "hey_smile".tr(),
          style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600,
              shadows: [Shadow(color: Colors.black38, blurRadius: 4)]),
        ),
        bodyWidget: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              "camera_access".tr(),
              style: descripStyle(),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: _initCamera,
                style: skipButtonStyle(),
                child: Text(
                  "camera_access_button".tr(),
                  style: buttonTextStyle(),
                ))
          ],
        ));
  }

  SizedBox secondImage() {
    return SizedBox(
      width: 400,
      height: 500,
      child: Image.asset("assets/camera.png"),
    );
  }

  PageViewModel firstPage() {
    return PageViewModel(
        image: firstImage(),
        titleWidget: Column(
          children: [
            Text(
              'welcome'.tr(),
              style: welcomeStyle(),
            ),
            Text(
              textAlign: TextAlign.center,
              "glad_to_see".tr(),
              style: messageStyle(),
            )
          ],
        ),
        bodyWidget: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              textAlign: TextAlign.center,
              "descp1".tr(),
              style: descripStyle(),
            ),
          ],
        ));
  }

  SizedBox firstImage() {
    return SizedBox(
      height: 400,
      width: 500,
      child: Image.asset(
        "assets/12.jpg",
        fit: BoxFit.contain,
      ),
    );
  }

  DotsDecorator dotsDecorator() {
    return DotsDecorator(color: Colors.grey, activeColor: Colors.black);
  }

  ButtonStyle backNextButtonStyle() {
    return ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.black),
        iconColor: WidgetStatePropertyAll(Colors.white));
  }

  ButtonStyle doneButtonStyle() {
    return ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black));
  }

  void onSkipOrDone() async {
    bool isCameraGranted = await _checkCameraPermission();

    if (!isCameraGranted) {
      await _initCamera();
      isCameraGranted = await _checkCameraPermission();
    }
    if (mounted) {
      setState(() {});
    }
    if (mounted && isCameraGranted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  ButtonStyle skipButtonStyle() {
    return ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black));
  }

  TextStyle? welcomeStyle() {
    return GoogleFonts.montserrat(
        color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600);
  }

  TextStyle? descripStyle() {
    return GoogleFonts.montserrat(
        color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500);
  }

  TextStyle? messageStyle() {
    return GoogleFonts.montserrat(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600);
  }

  TextStyle? buttonTextStyle() {
    return TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
  }

  Future<void> _initCamera() async {
    try {
      // kamera izni al
      var status = await Permission.camera.request();

      if (status.isGranted && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Camera access approved")));
        List<CameraDescription> cameras = await availableCameras();
        if (cameras.isEmpty && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Available Camera not founded")));
          return;
        }
        // On kamerayi secme icin
        CameraDescription? frontCamera;
        for (var camera in cameras) {
          if (camera.lensDirection == CameraLensDirection.front) {
            frontCamera = camera;
            break;
          }
        }
        if (frontCamera == null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Front Camera is not founded")));
        }

        _camera = frontCamera;
        _resolutionPreset = ResolutionPreset.veryHigh;
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Camera access denied')));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error 404')));
      }
    }
  }

  Future<bool> _checkCameraPermission() async {
    var status = await Permission.camera.status;
    return status.isGranted;
  }
}
