// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';

class ITextField extends StatefulWidget {
  String label;
  String hintText;
  String? initialValue;
  ValueChanged<String> onChanged;
  int maxLine;
  ITextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.maxLine = 1,
    this.initialValue,
  }) : super(key: key);

  @override
  State<ITextField> createState() => _ITextFieldState();
}

class _ITextFieldState extends State<ITextField> {
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
  void didUpdateWidget(ITextField oldWidget) {
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
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
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
