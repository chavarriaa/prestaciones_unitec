import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextDate extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<void> valueHandler;
  const TextDate({
    Key? key,
    required this.label,
    required this.text,
    required this.valueHandler,
  }) : super(key: key);

  @override
  _TextDate createState() => _TextDate();
}

class _TextDate extends State<TextDate> {
  TextEditingController txtDateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: txtDateInput,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(
                  2000), //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2101));

          if (pickedDate != null) {
            print(
                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            print(
                formattedDate); //formatted date output using intl package =>  2021-03-16
            //you can implement different kind of Date Format here according to your requirement
            setState(() {
              txtDateInput.text = formattedDate;
              widget.valueHandler(formattedDate);
            });
          } else {
            print("Date is not selected");
          }
        },
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.label,
        ),
      ),
    );
  }
}
