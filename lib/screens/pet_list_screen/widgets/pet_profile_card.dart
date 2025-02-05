// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pet_app/components/sized_box.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/constants/textstyle_class.dart';
import 'package:mobile_pet_app/model/pet_model.dart';
import 'package:mobile_pet_app/screens/pet_list_screen/widgets/custom_image_clipper.dart';

class PetProfileCard extends StatelessWidget {
  PetProfileCard({
    super.key,
    required this.onFavoriteToggle,
    required this.size,
    required this.isDark,
    required this.petList,
  });

  final VoidCallback onFavoriteToggle;
  final Size size;
  final bool isDark;
  PetDetailsList? petList;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onFavoriteToggle,
      child: Container(
        width: size.width / 1.5,
        height: size.height / 3,
        decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
            border: Border.all(
              color: AppColors.borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomShapedImage(
                  imageUrl: petList?.imageUrl ?? '',
                  width: size.width,
                  height: size.height / 6.5,
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: InkWell(
                    onTap: onFavoriteToggle,
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.borderColor,
                      child: Icon(
                        CupertinoIcons.heart_fill,
                        color: AppColors.surfaceLight,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 10,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: petList?.gender == "Male"
                        ? AppColors.blueLight
                        : AppColors.pinkLight,
                    child: Icon(
                      petList?.gender == "Male"
                          ? Icons.male_rounded
                          : Icons.female_rounded,
                      color: petList?.gender == "Male"
                          ? AppColors.maleIconColor
                          : AppColors.femaleIconColor,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
            kHeight(8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                petList?.petName ?? '',
                style: TextstyleClass.primaryFont500(
                    14,
                    isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight),
              ),
            ),
            kHeight(10),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: isDark ? AppColors.iconDark : AppColors.iconLight,
                  size: 18,
                ),
                kWidth(3),
                SizedBox(
                  width: size.width / 4,
                  child: Text(
                    petList?.location ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: TextstyleClass.primaryFont400(
                        13,
                        isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
