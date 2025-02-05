import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:mobile_pet_app/constants/color_class.dart';
import 'package:mobile_pet_app/constants/image_class.dart';
import 'package:mobile_pet_app/constants/textstyle_class.dart';
import 'package:toastification/toastification.dart';

class AppUtils {
  ///To check internet connection
  static Future<bool> hasInternet() async {
    try {
      final url = Uri.parse('https://www.google.com');
      final response = await http.get(url);
      return response.statusCode == 200;
    } catch (e) {
      return false; // Request failed, so no internet connection
    }
  }

  /// Navigate to a new screen/widget
  static navigateTo(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  static showLoading(double size, bool isDark) {
    return SizedBox(
      height: size,
      child: Center(
        child: CupertinoActivityIndicator(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          radius: 15.0,
        ),
      ),
    );
  }

  static noDataWidget(double size, bool isDark) {
    return SizedBox(
      height: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImageClass.noDataFound,
          ),
          // const SizedBox(height: 8.0,),
          Text(
            'Opps! your pet list is empty',
            style: TextstyleClass.primaryFont500(
                14,
                isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight),
          ),
        ],
      ),
    );
  }

  static showToast(
    BuildContext context,
    String labelText,
    String message,
    bool isSuccess,
  ) {
    toastification.show(
      context: context, // optional if you use ToastificationWrapper

      autoCloseDuration: const Duration(seconds: 5),
      title: Text(
        labelText,
        style: TextstyleClass.primaryFont500(
            14, isSuccess ? AppColors.success : AppColors.error),
      ),
      description: Text(
        message,
        style: TextstyleClass.primaryFont500(12, AppColors.textSecondaryLight),
      ),
      alignment: Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 500),

      icon: Icon(isSuccess ? Icons.check : Icons.error_outline_rounded,
          color: isSuccess ? AppColors.success : AppColors.error),
      showIcon: true, // show or hide the icon
      primaryColor: isSuccess ? AppColors.success : AppColors.error,
      backgroundColor: AppColors.surfaceLight,
      // foregroundColor: const Color.fromARGB(255, 77, 70, 70),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: AppColors.transparent,
          blurRadius: 0,
          offset: Offset(0, 0),
          spreadRadius: 0,
        ),
      ],
      borderSide: const BorderSide(color: AppColors.borderColor),
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.onHover,
      closeOnClick: true,
      pauseOnHover: true,
      dragToClose: true,
      applyBlurEffect: false,
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      style: ToastificationStyle.minimal,
      callbacks: ToastificationCallbacks(
        onTap: (toastItem) => debugPrint('Toast ${toastItem.id} tapped'),
        onCloseButtonTap: (toastItem) =>
            debugPrint('Toast ${toastItem.id} close button tapped'),
        onAutoCompleteCompleted: (toastItem) =>
            debugPrint('Toast ${toastItem.id} auto complete completed'),
        onDismissed: (toastItem) =>
            debugPrint('Toast ${toastItem.id} dismissed'),
      ),
    );
  }
}
