import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UploadImage {
  static final ImagePicker picker = ImagePicker();
  static XFile? image;
  static dynamic codedImage;
  static Map? data;
  static pickImageFromDevice() async {
    image =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (image != null) {
      final String newPath = image!.path.split('/').last;
      codedImage = convertImage(image: File(image!.path));
      data = {
        "file": {
          "fileName": newPath,
          "content": codedImage,
          "contentType": "image/jpg"
        }
      };
    }
  }

  static reset() {
    image = null;
    codedImage = null;
    data = null;
  }

  static convertImage({required File image}) {
    List<int> imageBytes = image.readAsBytesSync();
    //print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
}
