import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pet_app/components/sized_box.dart';
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/constants/textstyle_class.dart';
import 'package:mobile_pet_app/provider/pet_provider.dart';
import 'package:mobile_pet_app/screens/add_pet_screen/add_pet_screen.dart';
import 'package:mobile_pet_app/utils/app_utils.dart';
import 'package:provider/provider.dart';

class SaveButton extends StatelessWidget {
  final Size size;
  final bool isDark;
  final bool listScreen;

  const SaveButton({
    super.key,
    required this.size,
    required this.isDark,
    required this.listScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 10),
      child: Consumer<PetDataProvider>(builder: (context, snapshot, _) {
        return InkWell(
          onTap: () {
            if (listScreen) {
              AppUtils.navigateTo(context, const AddPetScreen());
            } else {
              // Validate form before submission
              if (!snapshot.validateForm() || snapshot.selectedImage == null) {
                AppUtils.showToast(
                  context,
                  'Error',
                  'Please fill in all required fields',
                  false,
                );
                return;
              }
              // If validation passes, submit the form
              snapshot.addPetMethod(context);
            }
          },
          child: Container(
            width: size.width,
            height: size.height * 0.075,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: isDark
                    ? AppColors.addPetButtonDark
                    : AppColors.addPetButtonLight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                listScreen
                    ? const Icon(
                        Icons.add_box_rounded,
                        color: AppColors.surfaceDark,
                      )
                    : kWidth(0),
                kWidth(6),
                snapshot.isLoading
                    ? const Center(
                        child: CupertinoActivityIndicator(
                          color: AppColors.surfaceDark,
                          radius: 12,
                        ),
                      )
                    : Text(
                        listScreen ? "Add new pet" : "Submit",
                        style: TextstyleClass.primaryFont500(
                            18, AppColors.textPrimaryLight),
                      )
              ],
            ),
          ),
        );
      }),
    );
  }
}
