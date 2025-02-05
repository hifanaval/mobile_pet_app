// custom_dropdown.dart
import 'package:flutter/material.dart';
import 'package:mobile_pet_app/components/sized_box.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/constants/textstyle_class.dart';

class CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final void Function(String?) onChanged;
  final String? hintText;

  const CustomDropdown({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          label,
          style: TextstyleClass.primaryFont500(14, AppColors.textSecondaryLight),
        ),
        kHeight(13),

        // Dropdown Container
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightBg,
            border: Border.all(color: AppColors.containerBorder, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                hintText ?? 'Select ${label.toLowerCase()}',
                style: TextstyleClass.primaryFont400(14, AppColors.textSecondaryDark),
              ),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextstyleClass.primaryFont500(14, AppColors.textPrimaryLight),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textSecondaryLight),
              dropdownColor: AppColors.lightBg,
            ),
          ),
        ),
      ],
    );
  }
}