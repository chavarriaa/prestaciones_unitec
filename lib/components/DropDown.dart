import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final String label;
  final List<String> items;
  final ValueChanged<void> valueHandler;

  const DropDown({
    Key? key,
    required this.label,
    required this.items,
    required this.valueHandler,
  }) : super(key: key);

  @override
  _DropDown createState() => _DropDown();
}

class _DropDown extends State<DropDown> {
  String? _value;
  TextEditingController txtBox = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: DropdownButtonFormField(
        value: _value,
        isExpanded: true,
        items: widget.items.map(
          (String? item) {
            return DropdownMenuItem<String>(
              child: Text(item.toString()),
              value: item.toString(),
            );
          },
        ).toList(),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          labelText: widget.label,
        ),
        onChanged: (value) {
          _value = value.toString();
        },
      ),
    );
  }
}
