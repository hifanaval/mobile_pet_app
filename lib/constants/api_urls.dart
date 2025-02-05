class ApiUrls {
  static String baseUrl = 'https://rnf.rankuhigher.in/api';

  static String getPetData() {
    return '$baseUrl/get/form';
  }

  static String addNewPet() {
    return '$baseUrl/register/form';
  }
}
