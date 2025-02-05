// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_pet_app/constants/api_urls.dart';
import 'package:mobile_pet_app/model/pet_model.dart';
import 'package:mobile_pet_app/screens/pet_list_screen/pet_list_screen.dart';
import 'package:mobile_pet_app/utils/app_utils.dart';
import 'package:mobile_pet_app/utils/get_service_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class PetDataProvider extends ChangeNotifier {
  bool isDataLoading = false;
  bool isLoading = false;

  List<PetDetailsList>? petDataList;
  TextEditingController petName = TextEditingController();
  TextEditingController petOwnerName = TextEditingController();
  TextEditingController additionalNote = TextEditingController();
  TextEditingController locationController = TextEditingController();

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Dropdown values
  String? selectedPetType;
  String? selectedGender;

  // Dropdown items
  final List<String> petTypes = [
    'Dog',
    'Cat',
    'Bird',
    'Fish',
    'Rabbit',
    'Hamster',
    'Other'
  ];

  final List<String> genderTypes = ['Male', 'Female'];

  // Dropdown change handlers
  void updatePetType(String? newValue) {
    selectedPetType = newValue;
    notifyListeners();
  }

  void updateGender(String? newValue) {
    selectedGender = newValue;
    notifyListeners();
  }

  // Image picking methods
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        selectedImage = File(image.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  // Clear selected image
  void clearSelectedImage() {
    selectedImage = null;
    notifyListeners();
  }

  void fetchPetDetails(BuildContext context) async {
    petDataList?.clear();
    setDataLoading(true);
    try {
      final jsonData =
          await GetServiceUtils.fetchData(ApiUrls.getPetData(), context);

      petDataList = petDetailsListFromJson(jsonData);

      debugPrint("Data fetched successfully");
      debugPrint("Parsed JSON Data: $jsonData");
    } catch (e, stackTrace) {
      debugPrint('Pet Data Error: $e');
      debugPrint('Stack trace: $stackTrace');
    }

    setDataLoading(false);
  }

  //post method
  Future<void> addPetMethod(BuildContext context) async {
    try {
      setProfileUpdate(true);
      Uri url = Uri.parse(ApiUrls.addNewPet());
      debugPrint("addPet url: ${ApiUrls.addNewPet()}");
      var request = http.MultipartRequest('POST', url);
      request.fields['pet_name'] = petName.text;
      request.fields['user_name'] = petOwnerName.text;
      request.fields['pet_type'] = selectedPetType ?? "Animal";
      request.fields['gender'] = selectedGender ?? "Male";
      request.fields['location'] = locationController.text;

      if (selectedImage != null) {
        var mimeType = lookupMimeType(selectedImage!.path);
        var multipartFile = await http.MultipartFile.fromPath(
          'image',
          selectedImage!.path,
          contentType: MediaType.parse(mimeType ?? 'application/octet-stream'),
        );
        request.files.add(multipartFile);
      }

      final response =
          await request.send().timeout(const Duration(seconds: 30));
      final responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        setProfileUpdate(false);
        debugPrint("Profile successfully updated: ${responseBody.body}");
        AppUtils.showToast(
            context, 'Success', 'Profile updated successfully!', true);
        fetchPetDetails(context);
        resetForm();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PetListScreen()));
        notifyListeners();
      } else {
        setProfileUpdate(false);
        debugPrint("Failed to update profile. Status: ${response.statusCode}");
        AppUtils.showToast(context, 'Error',
            'Failed to update profile. Please try again.', false);
      }
    } catch (e) {
      setProfileUpdate(false);
      debugPrint("Mobile update error: $e");
      AppUtils.showToast(context, 'Error', '$e', false);
    } finally {
      setProfileUpdate(false);
    }
  }

  void setProfileUpdate(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void setDataLoading(bool loading) {
    isDataLoading = loading;
    notifyListeners();
  }

  // Reset form
  void resetForm() {
    petName.clear();
    petOwnerName.clear();
    selectedPetType = null;
    selectedGender = null;
    selectedImage = null;
    notifyListeners();
  }

  // Form validation
  bool validateForm() {
    return petName.text.isNotEmpty &&
        petOwnerName.text.isNotEmpty &&
        selectedPetType != null &&
        selectedGender != null;
  }
}
