import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class ITextFieldFilePicker extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController textEditingController;
  final int maxLine;

  ITextFieldFilePicker({
    Key? key,
    required this.label,
    required this.hintText,
    required this.textEditingController,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.blue),
        ),
        TextField(
          maxLines: maxLine,
          controller: textEditingController,
          readOnly: true, // Prevent manual input
          onTap: () async {
            print(":rfsadfasd");
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.any, // Allow any file type
            );

            if (result != null) {
              // Get the file name and display it in the TextField
              String fileName = result.files.single.name;
              textEditingController.text = fileName;
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
            suffixIcon: GestureDetector(
              onTap: () async {
                // Open the File Picker when the icon is tapped
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.any, // Allow any file type
                );

                if (result != null) {
                  // Get the file name and display it in the TextField
                  String fileName = result.files.single.name;
                  textEditingController.text = fileName;
                }
              },
              child: const Icon(Icons.attach_file),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
