import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  String fieldText;
  TextEditingController textController;
  IconData? fieldIcon;
  IconData? fieldIcon2;
  bool hideText;
  Color? iconColor;
  TextInputType keyboardType;
  CustomSearchBar({
    required this.fieldText,
    required this.textController,
    required this.keyboardType,
    required this.hideText,
    this.fieldIcon,
  });
  String? fieldHintText, fieldPrefixText;

  bool ispasswordNotVisible = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      cursorColor: Colors.black,
      enableSuggestions: true,
      keyboardType: keyboardType,
      autocorrect: true,
      obscureText: hideText,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        hintTextDirection: TextDirection.ltr,
        enabledBorder: InputBorder.none,
        filled: true,
        fillColor: Color(0xffF0F0F0),
        // focusColor: Colors.yellowAccent,
        // hoverColor: Colors.yellow,

        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: Color(0xffF0F0F0),
          ),
        ),

        suffixIcon: Icon(fieldIcon),
        prefixIcon: Icon(Icons.search),
        label: Text(fieldText),
        hintText: 'Search',
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
