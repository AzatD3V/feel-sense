import 'package:flutter/material.dart';

class FaceImage extends StatelessWidget {
  final double height;
  final double width;
  const FaceImage({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: height * 0.09,
      child: Container(
        height: height * 0.25,
        width: width,
        decoration: const BoxDecoration(color: Colors.black),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: imageShow(210, 95, 'assets/2.jpg'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: imageShow(100, 100, 'assets/1.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: imageShow(100, 100, 'assets/4.jpg'),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(4),
              child: imageShow(210, 95, 'assets/5.jpg'),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: imageShow(100, 100, 'assets/3.jpg'),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: imageShow(100, 100, 'assets/6.jpg'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageShow(double height, double width, String imagePath) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
