import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class ImageProcessor {
  String? lastImagePath; // ✅ Fotoğrafın yolunu saklamak için değişken ekledik

  Future<List<List<List<List<double>>>>> processImage(
      BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      throw Exception('Image note selected');
    }

    File imageFile = File(pickedFile.path);
    lastImagePath = imageFile.path; // ✅ Fotoğrafın yolunu kaydet

    img.Image? image = img.decodeImage(await imageFile.readAsBytes());

    if (image == null) {
      throw Exception("Görsel çözümlenemedi!");
    }

    // 64x64 boyutuna yeniden boyutlandır
    img.Image resized = img.copyResize(image, width: 48, height: 48);

    // Gri tonlamaya çevir
    img.Image grayscale = img.grayscale(resized);

    // 64x64 giriş tensoru oluştur (Pixel değerlerinden renk bilgisi çek)
    List<List<List<List<double>>>> inputTensor = List.generate(
      1,
      (i) => List.generate(
        48,
        (j) => List.generate(
          48,
          (k) {
            img.Pixel pixel = grayscale.getPixel(j, k);
            num red = pixel.r; // Grayscale olduğu için kırmızı kanal yeterli
            return [red / 255.0]; // 0 ile 1 arasında normalize et
          },
        ),
      ),
    );

    return inputTensor;
  }
}
