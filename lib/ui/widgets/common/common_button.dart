import 'package:campus_transit/core/constants.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool greenColor;
  const CommonButton(
      {Key key, this.onPressed, this.label, this.greenColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size.width / 3,
        padding: EdgeInsets.symmetric(
          // horizontal: 15.0,
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          // color: UIData.greyColor,
          color: greenColor ? UIData.primaryColor : Colors.white,
          border: Border.all(
            color: greenColor ? Colors.white : Colors.black,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: greenColor ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
