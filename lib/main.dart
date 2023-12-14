import 'package:flutter/material.dart';
import 'views/map_view.dart';
import 'views/camera_view.dart';
import 'package:osm_map/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapView(),
      routes: {
        '/camera_view': (context) => CameraView(),
      },
    );
  }
}