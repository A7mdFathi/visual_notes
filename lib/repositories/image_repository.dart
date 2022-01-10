import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

@injectable
class ImageRepository {
  Future<File?> getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return null;

      final imagePermanent = await saveImagePermanently(image.path);
      return imagePermanent;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    } catch (e) {
      rethrow;
    }
  }

  File? loadImage(String imgPath) {
    final image = File(imgPath);
    return image;
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }
}
