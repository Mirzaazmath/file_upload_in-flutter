import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../provider/upload_files_provider.dart';
import '../utils/text_utlis.dart';
import '../utils/toast.dart';


// CUSTOM DAILOG CLASS
class CustomNameDialogBox extends StatefulWidget {
  final String id;
  const CustomNameDialogBox(this.id, {super.key});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomNameDialogBox> {
  final TextEditingController _nameController = TextEditingController();
  FilePickerResult? result;
  String selectedFileName = '';
  XFile? selectedFile;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.only(
                left: Constants.padding,
                top: Constants.padding,
                right: Constants.padding,
                bottom: Constants.padding),
            margin: const EdgeInsets.only(
              top: Constants.padding,
            ),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(Constants.padding),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 10),
                      blurRadius: 10),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TextUtil(
                      text: "Add Attachment",
                      weight: true,
                      size: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const TextUtil(
                  text: "Upload Attachment",
                  weight: true,
                  size: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        pickFilefromDevice();
                      },
                      child: Container(
                          height: 35,
                          width: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xff2876F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Upload",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: selectedFileName == ""
                            ? const SizedBox()
                            : SizedBox(
                          child: Chip(
                              onDeleted: () {
                                setState(() {
                                  selectedFile = null;
                                  selectedFileName = "";
                                });
                              },
                              label: Text(selectedFileName)),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextUtil(
                  text: "Comments",
                  weight: true,
                  size: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(2, 2),
                            blurRadius: 2),
                        BoxShadow(
                            color: Colors.grey.shade300,
                            offset: const Offset(-2, -2),
                            blurRadius: 2)
                      ]),
                  child: TextFormField(
                    controller: _nameController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: "Enter Comment", border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (selectedFile == null) {
                          showToast("Please Select file");
                        } else if (_nameController.text == "") {
                          showToast("Please Enter Comment");
                        } else {
                          context
                              .read<UploadAttachmentProvider>()
                              .uploadAttachmentImage(
                            selectedFile!,
                            _nameController.text,
                            widget.id,
                          );
                         // context.read<FetchAttachmentDataProvider>().update();

                          Navigator.pop(context);
                        }
                      },
                      child: Container(
                          height: 35,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xff2876F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  pickFilefromDevice() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final File myFile = File(result?.files.first.path ?? '');
      XFile file = XFile(myFile.path);

      setState(() {
        selectedFile = file;
        selectedFileName = file.name.toString();
      });
    } else {
      // showErrorToast("Something Went Wrong");
    }
  }
}


class Constants {
  Constants._();
  static const double padding = 20;
}
