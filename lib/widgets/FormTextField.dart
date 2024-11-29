// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sisi_super_app/constant/constans.dart';

class FormTextField extends StatefulWidget {
  final String? initialValue;
  final TextEditingController? value;
  final ValueChanged<String> onChanged;
  final String labelText;
  final String? hintText;
  final int? line;
  final double? topSpace;
  final bool? enable;
  final Color? valueColor;
  final Color? labelColor;
  final Color? borderColor;
  final double? labelSize;
  final Widget? suffix;
  final Color? fillColor;
  final bool? obscureText;
  final double? height;
  final bool? isIcon;

  const FormTextField({
    Key? key,
    this.initialValue = "",
    required this.onChanged,
    required this.labelText,
    this.line,
    this.hintText,
    this.topSpace,
    this.enable,
    this.suffix,
    this.fillColor,
    this.obscureText,
    this.height,
    this.labelColor,
    this.borderColor,
    this.labelSize,
    this.valueColor,
    this.isIcon,
    this.value,
  }) : super(key: key);

  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
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
  void didUpdateWidget(FormTextField oldWidget) {
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
    return widget.enable == false
        ? Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.labelText,
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    border: Border.all(color: Constans.sixth),
                    borderRadius: widget.isIcon == true
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(15))
                        : BorderRadius.circular(15.0)),
                child: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  widget.initialValue ?? "",
                  style: TextStyle(color: Colors.black45, fontSize: 16),
                ),
              ),
            ],
          )
        : Column(
            children: [
              widget.labelText != ""
                  ? Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        widget.labelText,
                        style: TextStyle(
                            color: widget.labelColor ?? Colors.black,
                            fontSize: widget.labelSize ?? 18),
                      ),
                    )
                  : Container(),
              Container(
                height: widget.height,
                margin: EdgeInsets.only(top: widget.topSpace ?? 12),
                child: TextField(
                  controller: _controller,
                  onChanged: widget.onChanged,
                  enabled: widget.enable ?? true,
                  maxLines: widget.line ?? 1,
                  style: TextStyle(
                      fontSize: 14, color: widget.valueColor ?? Colors.black54),
                  obscureText: widget.obscureText ?? false,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    hintText: widget.hintText ?? "",
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                    fillColor: widget.enable == false
                        ? Colors.grey.shade100
                        : Colors.white,
                    filled: true,
                    labelText: _focusNode.hasFocus ? null : null,
                    suffixIconColor: Constans.textColor,
                    suffixStyle: TextStyle(
                        color: Colors.amber, backgroundColor: Colors.amber),
                    suffix: widget.suffix,
                    labelStyle: TextStyle(
                        fontSize: 14, color: widget.labelColor ?? Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: widget.borderColor ?? Constans.sixth),
                        borderRadius: widget.isIcon == true
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15))
                            : BorderRadius.circular(15.0)),
                    disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: widget.borderColor ?? Constans.sixth),
                        borderRadius: widget.isIcon == true
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15))
                            : BorderRadius.circular(15.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: widget.borderColor ?? Constans.sixth),
                        borderRadius: widget.isIcon == true
                            ? BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                topLeft: Radius.circular(15))
                            : BorderRadius.circular(15.0)),
                  ),
                ),
              ),
            ],
          );
  }
}
