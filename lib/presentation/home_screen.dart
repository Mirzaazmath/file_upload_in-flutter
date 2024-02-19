import 'package:flutter/material.dart';

import '../widgets/custom_alertbox.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload File"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            _showUploadDailog(context);
          },
          child: Text("Upload file"),
        ),
      ),
    );
  }
  _showUploadDailog(context) async {
   await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CustomNameDialogBox("102406"));
        });

  }
}
