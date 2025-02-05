import 'package:flutter/material.dart';
import 'package:mobile_pet_app/components/sized_box.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/constants/textstyle_class.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color labelColor;
  final Color textColor;
  final int maxLines;

  const CustomTextField(
      {super.key,
      required this.label,
      this.hintText,
      this.controller,
      this.validator,
      this.keyboardType,
      this.obscureText = false,
      this.suffixIcon,
      this.onChanged,
      this.readOnly = false,
      this.onTap,
      this.backgroundColor,
      this.labelColor = Colors.grey,
      this.textColor = Colors.black,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(label,
            style: TextstyleClass.primaryFont500(
                14, AppColors.textSecondaryLight)),
        kHeight(13),

        // Text Field Container
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            border: Border.all(color: AppColors.containerBorder, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            obscureText: obscureText,
            onChanged: onChanged,
            readOnly: readOnly,
            onTap: onTap,
            maxLines: maxLines  ,
            style:
                TextstyleClass.primaryFont500(14, AppColors.textPrimaryLight),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextstyleClass.primaryFont400(
                  14, AppColors.textSecondaryDark),
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              border: InputBorder.none, // Removes the underline
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
