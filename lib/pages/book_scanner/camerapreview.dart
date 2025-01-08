import 'package:camera/camera.dart';
import 'package:ejazapp/core/services/services.dart';
import 'package:ejazapp/helpers/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
      this.camera,this.lang,
  });

  final List<CameraDescription>? camera;
  final String? lang;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  // Obtain a list of the available cameras on the device.
  
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
     widget.camera![0],
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!context.mounted) return;
            mybox!.put("camera", true);mybox!.put("imagepath", image.path);mybox!.put("langcamera", widget.lang);
            Get.toNamed(Routes.chatai);
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt,color: Colors.white,),
      ),
    );
  }
}
