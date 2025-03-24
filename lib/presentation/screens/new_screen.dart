import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xxx/presentation/screens/info_screens/hobbies_selection_screen.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({super.key});

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late Animation<double> animation1;
  late Animation<double> animation2;
  bool showSecondText = false;

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation1 = Tween<double>(begin: 0.1, end: 1.0)
        .animate(CurvedAnimation(parent: controller1, curve: Curves.easeOut));
    controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation2 = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller2, curve: Curves.easeOut));
    controller2.forward().then((_) {
      Future.delayed(Duration(milliseconds: 1200), () {
        setState(() {
          showSecondText = true;
        });
        controller1.forward().then((_) {
          Future.delayed(Duration(seconds: 1), () {
            if (mounted) {
              Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => HobbiesSelectionScreen()));
            }
          });
        });
      });
    });
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showSecondText
                ? FadeTransition(
                    opacity: animation1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Size özel öneriler için \nbazı bilgilere ihtiyacımız var",
                        style: GoogleFonts.montserrat(
                            color: Colors.white, fontSize: 30),
                      ),
                    ),
                  )
                : FadeTransition(
                    opacity: animation2,
                    child: Text(
                      "Merhaba",
                      style: GoogleFonts.montserrat(
                          color: Colors.white, fontSize: 35),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
