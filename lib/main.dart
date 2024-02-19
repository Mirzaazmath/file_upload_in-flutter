import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:upload_file/presentation/home_screen.dart';
import 'package:upload_file/provider/upload_files_provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      MultiProvider(
    providers: [

      ChangeNotifierProvider(
        create: (context) => UploadAttachmentProvider(),
      ),

    ],
        child:  const MyApp(),

  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),

    );
  }
}

