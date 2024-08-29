import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      cursorColor: Colors.black26,
      enableSuggestions: true,
      spellCheckConfiguration: SpellCheckConfiguration(
        spellCheckService: DefaultSpellCheckService(),
      ),
      keyboardType: widget.keyboardType,
      autocorrect: true,
      obscureText: widget.fieldText == 'Password' ||
              widget.fieldText == 'Confirm Password'
          ? ispasswordNotVisible
          : widget.hideText,
      decoration: InputDecoration(
        fillColor: Colors.black,
        focusColor: Color(0xffEFCC4E),
        hoverColor: Color(0xffEFCC4E),
        floatingLabelStyle: TextStyle(
          color: Color(0xffEFCC4E),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
          borderSide: BorderSide(
            color: Color(0xffF8B31A),
          ),
        ),
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
            : Icon(widget.fieldIcon),
        label: Text(widget.fieldText),
        //hintText: fieldHintText,
        prefixText: fieldPrefixText,
        border: const OutlineInputBorder(
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
