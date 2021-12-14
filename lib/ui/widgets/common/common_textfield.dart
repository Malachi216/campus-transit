import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class CommonTextField extends StatelessWidget {
  final String hintText;
  final bool slimLayout;
  final bool autofocus;
  final int maxLines;
  final Widget suffixIcon;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final TextEditingController textController;
  final bool obscureText;
  final Function(String) validator;
  final TextStyle hintStyle;
  final FocusNode focusNode;
  final EdgeInsets padding;

  const CommonTextField({
    Key key,
    this.hintText,
    this.slimLayout = true,
    this.autofocus = false,
    this.maxLines,
    this.suffixIcon,
    this.onChanged,
    this.textController,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.focusNode,
    this.hintStyle,
    this.padding = const EdgeInsets.all(0.0),
    // this.hintStyle = UIData.onBoardingHintTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder fieldBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
      borderRadius: BorderRadius.circular(7.0),
    );

    UnderlineInputBorder focusedFieldBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: UIData.primaryColor, width: 1.0),
      borderRadius: BorderRadius.circular(7.0),
    );

    OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.0),
      borderRadius: BorderRadius.circular(7.0),
    );

    // FocusNode _focusNode = FocusNode();

    return Padding(
      padding: padding,
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChanged,
        autofocus: autofocus,
        maxLines: maxLines,
        controller: textController,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: TextInputAction.next,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          enabledBorder: fieldBorder,
          focusedBorder: focusedFieldBorder,
          // fillColor: UIData.onboardingTextFieldColor.withOpacity(0.24),
          suffixIcon: suffixIcon,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          filled: true,
        ),
        textAlign: TextAlign.start,
        // style: slimLayout
        //     ? UIData.onBoardingHintTextStyle
        //     : UIData.onBoardingHintTextStyle.copyWith(fontSize: 24),
      ),
    );
  }
}
