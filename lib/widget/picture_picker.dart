import 'dart:developer';

import 'package:image_picker/image_picker.dart';

class PicturePickerResult {
  dynamic error;
  XFile? image;
}

Future<PicturePickerResult> showPicturePicker(ImageSource source) async {
  final result = PicturePickerResult();
  try {
    result.image = await ImagePicker().pickImage(
      source: source,
      maxWidth: 640,
      maxHeight: 640 * (16 / 9),
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 70,
    );
    // print("${result.image!.name} ${result.image!.path}");
  } catch (e) {
    inspect(e);
    result.error = e;
  }
  return result;
}
