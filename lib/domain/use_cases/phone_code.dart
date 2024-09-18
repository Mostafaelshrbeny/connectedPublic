class PhoneCode {
  static String? code, phone;
  static setCode({required String newCode, required String pNumber}) {
    code = newCode;
    phone = pNumber;
  }

  static handelNum(String phoneNum) {
    if (phoneNum.contains("+20")) {
      phone = phoneNum.split("+20")[1];
      code = "+20";
      return phoneNum.split("+20")[1];
    } else {
      code = "+20";
      phone = phoneNum.substring(1);
      return phoneNum.substring(1);
    }
  }
}
