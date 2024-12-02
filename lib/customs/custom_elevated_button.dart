import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:registrationapp/customs/custom_colors.dart';


class CustomElevatedButton extends StatelessWidget {
  final String label; // Button text
  final VoidCallback onPressed; // Action when button is pressed
  final Color backgroundColor; // Button background color
  final Color textColor; // Text color
  final double borderRadius; // Button corner radius
  final EdgeInsetsGeometry padding; // Button padding
  final double fontSize; // Text font size
  final Widget? icon; // Optional icon for the button
  final bool isLoading; // Whether to show a loading indicator
  final Color? loadingIndicatorColor; // Color for the loading indicator

  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor = primaryColor,
    this.textColor = black,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.fontSize = 16,
    this.icon,
    this.isLoading = false,
    this.loadingIndicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: isLoading
          ? SizedBox(
        height: 24.h,
        width: 24.w,
        child: CircularProgressIndicator(
          color: loadingIndicatorColor ?? textColor,
          strokeWidth: 2.5,
        ),
      )
          : Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
             SizedBox(width: 8.w),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize.sp,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
