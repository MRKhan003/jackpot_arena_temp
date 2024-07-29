import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InputFields extends StatefulWidget {
  String fieldText;
  TextEditingController textController;
  IconData? fieldIcon;
  IconData? fieldIcon2;
  bool hideText;
  Color? iconColor;
  TextInputType keyboardType;
  InputFields({
    required this.fieldText,
    required this.textController,
    required this.keyboardType,
    required this.hideText,
    this.fieldIcon,
  });

  @override
  State<InputFields> createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  String? fieldHintText, fieldPrefixText;

  bool ispasswordNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      enableSuggestions: true,
      keyboardType: widget.keyboardType,
      autocorrect: true,
      obscureText: widget.fieldText == 'Password' ||
              widget.fieldText == 'Confirm Password'
          ? ispasswordNotVisible
          : widget.hideText,

      autofocus: fieldHintText == null ? false : true,
      readOnly: fieldHintText == null ? false : true,
      //restorationId: "Name",
      decoration: InputDecoration(
        suffixIcon: widget.fieldText == 'Password' ||
                widget.fieldText == 'Confirm Password'
            ? IconButton(
                onPressed: () {
                  setState(() {
                    ispasswordNotVisible = !ispasswordNotVisible;
                  });
                },
                color: ispasswordNotVisible ? widget.iconColor : Colors.blue,
                icon: Icon(
                  ispasswordNotVisible ? widget.fieldIcon : Icons.visibility,
                ),
              )
            : null,
        label: Text(widget.fieldText),
        hintText: fieldHintText,
        prefixText: fieldPrefixText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }
}
