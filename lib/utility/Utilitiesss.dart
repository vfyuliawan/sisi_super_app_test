// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sisi_super_app/constant/constans.dart';
import 'package:sisi_super_app/utility/model_utils/model_image_picker.dart';

class Utilities {
  final ImagePicker _picker = ImagePicker();

  Timer? _debounce;
  void debounceSearch(Function callBack, {int milliseconds = 500}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: milliseconds), () {
      callBack();
    });
  }

  Future<bool?> showMessage({String? message}) {
    return Fluttertoast.showToast(
        msg: message ?? "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: Constans.sixth,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Color cekColor(String themeNme) {
    if (themeNme == Constans.theme.redEssence) {
      return Constans.redEssence;
    } else if (themeNme == Constans.theme.bluePremium) {
      return Constans.bluePremium;
    } else if (themeNme == Constans.theme.luxuryCream) {
      return Constans.luxuryCream;
    } else if (themeNme == Constans.theme.luxuryGreen) {
      return Constans.luxuryGreen;
    } else if (themeNme == Constans.theme.luxuryPink) {
      return Constans.luxuryPink;
    } else {
      return Constans.primaryColor;
    }
  }

  bool validateFields(Map<String, dynamic> data) {
    for (var value in data.values) {
      if (value == null || (value is String && value.isEmpty)) {
        return false;
      }
    }
    return true;
  }

  Future<ModelImagePicker?> pickedImage() async {
    try {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 70);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileSizeInBytes = await file.length();
        final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        print(fileSizeInMB);
        print(pickedFile.mimeType);
        print(fileSizeInBytes);

        if (fileSizeInMB > 2) {
          Utilities()
              .showMessage(message: "Image size exceeds 2 MB, cannot upload.");
          return null;
        } else {
          final bytes = await pickedFile.readAsBytes();
          final base64Image = base64Encode(bytes);

          // Extract the image name (without extension)
          final imageName = basenameWithoutExtension(pickedFile.path);
          print("Image Name: $imageName");

          // Determine MIME type, default to image/jpeg if unknown
          final mimeType = pickedFile.mimeType ?? 'image/png';
          final base64WithPrefix = 'data:$mimeType;base64,$base64Image';

          // Return the image name and the base64 string
          return ModelImagePicker.fromMap({
            'nameImage': imageName,
            'base64': base64WithPrefix,
          });
        }
      } else {
        Utilities().showMessage(message: "No Image Selected");
        return null;
      }
    } catch (e) {
      Utilities().showMessage(message: e.toString());
      return null;
    }
  }

  Future<String?> pickedImageCamera() async {
    try {
      final pickedFile =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);
      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final fileSizeInBytes = await file.length();
        final fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        print(fileSizeInMB);
        print(pickedFile.mimeType);
        print(fileSizeInBytes);

        if (fileSizeInMB > 2) {
          Utilities()
              .showMessage(message: "Image size exceeds 2 MB, cannot upload.");
          return null;
        } else {
          final bytes = await pickedFile.readAsBytes();
          final base64Image = base64Encode(bytes);

          // Determine MIME type, default to image/jpeg if unknown
          final mimeType = 'image/png';
          final base64WithPrefix = 'data:$mimeType;base64,$base64Image';

          return base64WithPrefix;
        }
      } else {
        Utilities().showMessage(message: "No Image Selected");
        return null;
      }
    } catch (e) {
      Utilities().showMessage(message: e.toString());
      return null;
    }
  }

  Future<void> downloadBase64Image(String base64Image, String fileName) async {
    try {
      final parts = base64Image.split(',');
      final actualBase64 = parts.length > 1 ? parts[1] : parts[0];
      Uint8List imageBytes = base64Decode(actualBase64);

      // Get the downloads directory
      Directory? downloadsDirectory = await getExternalStorageDirectory();
      if (downloadsDirectory == null) {
        throw Exception("Downloads directory not found");
      }

      // Define the file path
      String path = "${downloadsDirectory.path}/Download";
      Directory downloadFolder = Directory(path);

      // Create the downloads folder if it doesn't exist
      if (!downloadFolder.existsSync()) {
        downloadFolder.createSync(recursive: true);
      }

      // Save the image
      File file = File("${downloadFolder.path}/$fileName.jpg");
      await file.writeAsBytes(imageBytes);

      Utilities().showMessage(message: "Download Image Success");
    } catch (e) {
      print("Error saving image: $e");
    }
  }

  void showDialogConfrimation(BuildContext context, String title, String desc,
      Function onSubmit) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Constans.fourthColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
            side: BorderSide(color: Constans.sixth, width: 4), // Blue border
          ),
          shadowColor: Colors.black54,
          titleTextStyle: TextStyle(
              color: Constans.sixth,
              fontFamily: "Roboto-Black",
              fontSize: 24,
              fontWeight: FontWeight.bold),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Container(
            // decoration: BoxDecoration(color: Colors.red),
            height: 300,
            width: 300,
            child: Column(
              children: [
                Container(
                  height: 160,
                  child: Image.asset("assets/images/please.png",
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(desc),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          // ignore: sort_child_properties_last
                          child: Text(
                            "No",
                            style: TextStyle(
                                fontFamily: 'Roboto-Black',
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Constans.sixth,
                          ),
                          width: 70,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          onSubmit();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          // ignore: sort_child_properties_last
                          child: Text(
                            "Yes",
                            style: TextStyle(
                                fontFamily: 'Roboto-Black',
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Constans.sixth,
                          ),
                          width: 70,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }

  void showModalInfo(
      BuildContext context, String title, String desc, String? image) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Constans.fourthColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Rounded corners
            side: BorderSide(color: Constans.sixth, width: 4), // Blue border
          ),
          shadowColor: Colors.black54,
          titleTextStyle: TextStyle(
              color: Constans.sixth,
              fontFamily: "Roboto-Black",
              fontSize: 24,
              fontWeight: FontWeight.bold),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Container(
            // decoration: BoxDecoration(color: Colors.red),
            height: 300,
            width: 300,
            child: Column(
              children: [
                Container(
                  height: 160,
                  child: Image.asset(image ?? "assets/images/please.png",
                      fit: BoxFit.cover),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          // ignore: sort_child_properties_last
                          child: Text(
                            "Tutup",
                            style: TextStyle(
                                fontFamily: 'Roboto-Black',
                                fontSize: 16,
                                color: Colors.white),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Constans.sixth,
                          ),
                          width: 70,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
