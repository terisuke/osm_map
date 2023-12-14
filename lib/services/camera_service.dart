import 'package:camera/camera.dart';



class CameraService {
  CameraController? controller;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await controller?.initialize();
  }

  Future<XFile?> takePicture() async {
    if (!controller!.value.isInitialized) {
      print('Controller is not initialized');
      return null;
    }

    if (controller!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      XFile file = await controller!.takePicture();
      return file;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void dispose() {
    controller?.dispose();
  }

}