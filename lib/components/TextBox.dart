import 'package:flutter/material.dart';

class TextBox extends StatefulWidget {
  final String label;
  final text;
  final ValueChanged<void> valueHandler;
  final TextInputType keyboardType;

  const TextBox(
      {Key? key,
      required this.label,
      required this.text,
      required this.valueHandler,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  _TextBox createState() => _TextBox();
}

class _TextBox extends State<TextBox> {
  TextEditingController txtBox = TextEditingController();

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    txtBox.text = widget.text;
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        txtBox.selection =
            TextSelection(baseOffset: 0, extentOffset: txtBox.text.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        keyboardType: widget.keyboardType,
        controller: txtBox,
        focusNode: _focusNode,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.label,
        ),
        onChanged: (value) {
          setState(() {
            widget.valueHandler(value);
          });
        },
      ),
    );
  }
}
