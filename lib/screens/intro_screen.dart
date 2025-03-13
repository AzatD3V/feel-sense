import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:xxx/screens/home_screen.dart';
import 'package:xxx/screens/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final _introKey = GlobalKey<IntroductionScreenState>();

  List<PageViewModel> pages = [
    PageViewModel(
        title: "Page One",
        bodyWidget: Column(
          children: [
            Text('Firs Page'),
          ],
        )),
    PageViewModel(title: 'Page Two', bodyWidget: Text("data")),
    PageViewModel(title: 'Last Page', bodyWidget: Text('Last Page'))
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2D2926),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: IntroductionScreen(
        globalBackgroundColor: Color(0xff2D2926),
        key: _introKey,
        pages: pages,
        skip: Text(
          'Skip',
          style: buttonTextStyle(),
        ),
        onSkip: onSkip,
        next: Icon(
          Icons.arrow_forward_ios,
        ),
        done: Text(
          'Done',
          style: buttonTextStyle(),
        ),
        onDone: onDone,
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

  DotsDecorator dotsDecorator() {
    return DotsDecorator(
        color: Colors.grey.shade800, activeColor: Color(0xffed6f63));
  }

  ButtonStyle backNextButtonStyle() {
    return ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xffed6f63)),
        iconColor: WidgetStatePropertyAll(Colors.grey.shade900));
  }

  ButtonStyle doneButtonStyle() {
    return ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xffed6f63)));
  }

  void onDone() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void onSkip() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  ButtonStyle skipButtonStyle() {
    return ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xffed6f63)));
  }
}

TextStyle? buttonTextStyle() {
  return TextStyle(
      color: Colors.grey.shade900, fontSize: 16, fontWeight: FontWeight.w500);
}
