// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ITextFieldDropDown extends StatefulWidget {
  final List<ModelKeyValueDropDown> keyValueDropDownList;
  final String label;
  final String hintText;
  final String? initialValue;
  ValueChanged<String> onChanged;

  final int maxLine;

  ITextFieldDropDown({
    Key? key,
    required this.keyValueDropDownList,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.maxLine = 1,
    this.initialValue,
  }) : super(key: key);

  @override
  State<ITextFieldDropDown> createState() => _ITextFieldDropDownState();
}

class _ITextFieldDropDownState extends State<ITextFieldDropDown> {
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
  void didUpdateWidget(ITextFieldDropDown oldWidget) {
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
        DropdownButtonFormField<ModelKeyValueDropDown>(
          // value: keyValueDropDownList.isNotEmpty
          //     ? keyValueDropDownList[0]
          //     : ModelKeyValueDropDown(key: "", value: ""),
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
          onChanged: (ModelKeyValueDropDown? newValue) {
            if (newValue != null) {
              _controller.text = newValue.value;
              widget.onChanged(newValue.value);
            }
          },
          items: widget.keyValueDropDownList
              .map<DropdownMenuItem<ModelKeyValueDropDown>>(
                  (ModelKeyValueDropDown value) {
            return DropdownMenuItem<ModelKeyValueDropDown>(
              value: value,
              child: Text(value.value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ModelKeyValueDropDown {
  String key;
  String value;

  ModelKeyValueDropDown({
    required this.key,
    required this.value,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'key': key,
      'value': value,
    };
  }

  factory ModelKeyValueDropDown.fromMap(Map<String, dynamic> map) {
    return ModelKeyValueDropDown(
      key: map['key'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ModelKeyValueDropDown.fromJson(String source) =>
      ModelKeyValueDropDown.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
