// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

import 'package:sisi_super_app/utility/Utility.dart';
import 'package:sisi_super_app/utility/model_utils/model_image_picker.dart';

class ITextFieldImagePicker extends StatefulWidget {
  final String label;
  final String hintText;
  final String? initialValue;
  final int maxLine;
  ValueChanged<ModelImagePicker> onChanged;

  ITextFieldImagePicker({
    Key? key,
    required this.label,
    required this.hintText,
    this.initialValue,
    this.maxLine = 1,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ITextFieldImagePicker> createState() => _ITextFieldImagePickerState();
}

class _ITextFieldImagePickerState extends State<ITextFieldImagePicker> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? "");
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(ITextFieldImagePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? "";
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(color: Colors.blue),
        ),
        TextField(
          maxLines: widget.maxLine,
          controller: _controller,
          readOnly: true, // Prevent manual input
          onTap: () async {
            await Utility().pickedImage().then((value) {
              if (value != null) {
                print("name test, ${value.nameImage}");
                _controller.text = value.nameImage;
                widget.onChanged(value);
              }
            });
          },
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
            suffixIcon: GestureDetector(
              onTap: () async {
                await Utility().pickedImage().then((value) {
                  if (value != null) {
                    print("name test, ${value.nameImage}");
                    _controller.text = value.nameImage;
                    widget.onChanged(value);
                  }
                });
              },
              child: const Icon(Icons.attach_file),
            ),
            hintText: widget.hintText,
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
