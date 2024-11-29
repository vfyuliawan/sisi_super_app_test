// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class ITextFieldDateTime extends StatefulWidget {
  final String label;
  final String? initialValue;
  final String hintText;
  final int maxLine;
  ValueChanged<String> onChanged;

  ITextFieldDateTime({
    Key? key,
    required this.label,
    this.initialValue,
    required this.hintText,
    this.maxLine = 1,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<ITextFieldDateTime> createState() => _ITextFieldDateTimeState();
}

class _ITextFieldDateTimeState extends State<ITextFieldDateTime> {
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
  void didUpdateWidget(ITextFieldDateTime oldWidget) {
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
          readOnly: true, // Prevent manual input to focus only on DatePicker
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (selectedDate != null) {
              final formatDateString =
                  formatDate(selectedDate, [DD, ' ,', dd, ' ', MM, " ", yyyy]);
              _controller.text = formatDateString; // Update the text controller

              widget.onChanged(formatDateString);
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.grey.shade200,
            filled: true,
            suffixIcon: GestureDetector(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  final formatDateString = formatDate(
                      selectedDate, [DD, ' ,', dd, ' ', MM, " ", yyyy]);
                  _controller.text =
                      formatDateString; // Update the text controller

                  widget.onChanged(formatDateString);
                }
              },
              child: const Icon(Icons.calendar_today_outlined),
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
