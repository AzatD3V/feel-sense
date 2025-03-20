import 'package:flutter/material.dart';

class AnimatedBoxes extends StatefulWidget {
  const AnimatedBoxes({super.key});

  @override
  _AnimatedBoxesState createState() => _AnimatedBoxesState();
}

class _AnimatedBoxesState extends State<AnimatedBoxes>
    with TickerProviderStateMixin {
  late AnimationController _controller1;
  late AnimationController _controller2;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    _controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation1 = Tween<double>(begin: 30, end: 50).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.linear,
    ));

    _animation2 = Tween<double>(begin: 50.0, end: 30.0).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedBuilder(
          animation: index < 2 ? _animation1 : _animation2,
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.all(10),
              width: 10,
              height: (index % 2 == 0) ? _animation1.value : _animation2.value,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }
}
