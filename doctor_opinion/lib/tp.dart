import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class Singlefilepicker extends StatefulWidget {
  const Singlefilepicker({super.key});

  @override
  State<Singlefilepicker> createState() => _SinglefilepickerState();
}

class _SinglefilepickerState extends State<Singlefilepicker> {
  PlatformFile? file;
  Future<void> picksinglefile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {});
      file = result.files.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color.fromARGB(255, 49, 168, 215),
                Color.fromARGB(255, 58, 207, 100)
              ])),
            ),
            title: const Text(
              'File Picker',
              style: TextStyle(
                  color: Color.fromARGB(255, 59, 54, 54),
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            )),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ElevatedButton.icon(
                    onPressed: picksinglefile,
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 61, 186, 228))),
                    icon: const Icon(Icons.insert_drive_file_sharp),
                    label: const Text(
                      'Pick File',
                      style: TextStyle(fontSize: 25),
                    )),
                file != null
                    ? Container(
                        height: 200, color: Colors.amber, child: Text(""))
                    : SizedBox()
              ])),
        ));
  }
}
