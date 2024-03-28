import 'package:image_cropper/image_cropper.dart';

class ImageCropperResult {
  dynamic error;
  CroppedFile? image;
}

Future<ImageCropperResult> showImageCropper(String path) async {
  final result = ImageCropperResult();
  try {
    result.image = await ImageCropper().cropImage(
        sourcePath: path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 70,
        aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
        aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
        maxWidth: 640,
        maxHeight: (640 * (16 / 9)).toInt(),
        cropStyle: CropStyle.rectangle,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Crop image",
            initAspectRatio: CropAspectRatioPreset.ratio16x9,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
              minimumAspectRatio: 16 / 9,
              resetAspectRatioEnabled: true,
              aspectRatioPickerButtonHidden: true,
              rotateClockwiseButtonHidden: true,
              aspectRatioLockEnabled: false,
              rotateButtonsHidden: true,
              resetButtonHidden: true,
              doneButtonTitle: "done",
              showCancelConfirmationDialog: false,
              cancelButtonTitle: "close"),
        ]);
  } catch (e) {
    result.error = e;
  }
  return result;
}
