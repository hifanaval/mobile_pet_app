import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_pet_app/components/add_new_button.dart';
import 'package:mobile_pet_app/components/sized_box.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/constants/textstyle_class.dart';
import 'package:mobile_pet_app/provider/pet_provider.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_dropdown.dart';
import 'widgets/custom_textfield.dart';
import 'widgets/upload_image_button.dart';

class AddPetScreen extends StatelessWidget {
  const AddPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          surfaceTintColor:
              isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                radius: 17,
                backgroundColor: AppColors.lightGrey,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: isDark ? AppColors.iconDark : AppColors.iconLight,
                  size: 18,
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Add your pet detail",
            style:
                TextstyleClass.primaryFont500(18, AppColors.textPrimaryLight),
          ),
        ),
      ),
      body: Consumer<PetDataProvider>(builder: (context, petDataProvider, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: 'Your pet name',
                  hintText: 'Enter your pet name',
                  controller: petDataProvider.petName,
                ),
                kHeight(24),
                CustomTextField(
                  label: 'Your pet owner name',
                  hintText: 'Enter Your pet owner name',
                  controller: petDataProvider.petOwnerName,
                ),
                kHeight(24),
                CustomDropdown(
                  label: 'Type of Pet',
                  value: petDataProvider.selectedPetType,
                  items: petDataProvider.petTypes,
                  onChanged: petDataProvider.updatePetType,
                  hintText: 'Select pet type',
                ),
                kHeight(24),
                CustomDropdown(
                  label: 'Gender',
                  value: petDataProvider.selectedGender,
                  items: petDataProvider.genderTypes,
                  onChanged: petDataProvider.updateGender,
                  hintText: 'Select gender',
                ),
                kHeight(24),
                CustomTextField(
                  label: 'Enter pet location',
                  hintText: 'Enter Your pet location',
                  controller: petDataProvider.locationController,
                ),
                kHeight(24),
                CustomTextField(
                  label: 'Additional Texts',
                  controller: petDataProvider.additionalNote,
                  maxLines: 4,
                ),
                kHeight(30),
                Text(
                  "Add your pet profile picture and upload pet photos",
                  style: TextstyleClass.primaryFont500(
                      14, AppColors.textSecondaryLight),
                ),
                kHeight(24),
                ImageUploadButton(
                  height: size.height * 0.09, // Optional
                  width: double.infinity, // Optional
                ),
                // Consumer<PetDataProvider>(
                //   builder: (context, provider, _) {
                // if (provider.selectedImage == null) {
                //   return const SizedBox.shrink();
                // }
                kHeight(20),
                petDataProvider.selectedImage == null
                    ? kHeight(0)
                    : SizedBox(
                        height: 70,
                        width: 65,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.file(
                                  petDataProvider.selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: petDataProvider.clearSelectedImage,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.remove,
                                    size: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                kHeight(20),

                SaveButton(
                  isDark: isDark,
                  size: size,
                  listScreen: false,
                ),
                kHeight(20),
              ],
            ),
          ),
        );
      }),
    );
  }
}
