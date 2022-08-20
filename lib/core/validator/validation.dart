
class Validator {

  static String? generalField(String? value){
    if(value!.isEmpty) return 'حقل فارغ!';
    else return null;
  }

  static String? dropMenu(value){
    if(value == null) return 'حقل فارغ!';
    else return null;
  }

  static String? number(String? value){
    if(value!.isEmpty) return 'حقل فارغ!';
    else return null;
  }

  static String? email(String? value){
    if(value!.isEmpty) return 'حقل فارغ!';
    else if (!value.contains('@') || !value.contains('.')) return 'EX: example@mail.com';
    else return null;
  }

  static String? phoneNumber(String? value){
    if(value!.isEmpty) return 'حقل فارغ!';
    else if (!value.startsWith('05')) return 'رقم الجوال يجب ان يبدأ بالرقم 05';
    else if (value.length != 10) return 'رقم الجوال يجب ان يتكون من ١٠ ارقام';
    else return null;
  }

  static String? pinCode(String? value){
    if(value!.isEmpty) return 'حقل فارغ!';
    else if(value.length != 4) return 'الكود يجب ان يتكون من 4 ارقام';
    else return null;
  }

  static String? password(String? value){
    if(value!.isEmpty) return 'حقل فارغ!';
    else if(value.length < 6) return 'كلمة المرور يجب الا تقل عن ٦ احرف';
    else return null;
  }

  static String? confirmPassword(String value,String password){
    if(value.isEmpty) return 'حقل فارغ!';
    else if(value.length < 6) return 'كلمة المرور يجب الا تقل عن ٦ احرف';
    else if(password != value) return 'كلمة المرور غير متطابقة';
    else return null;
  }

  static String? name(String? value){
    if(value!.isEmpty) return 'حقل فارغ!';
    else if(value.length < 2) return 'الاسم يجب الا يقل عن 2 احرف';
    else return null;
  }

  static String? notes(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else return null;
  }

  static String? enquiry(String? value){
    if(value!.isEmpty) return 'حقل فارغ!';
    else if(value.length < 10 || value.length > 3000) return "رسالتك يجب ان تكون اكبر من ١٠ احرف واقل من ٣٠٠٠";
    else return null;
  }

  static String? search(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else return null;
  }

  static String? address(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else if(value.length < 10 || value.length > 50) return 'العنوان يجب ان يكون اكبر من ١٠ احرف واقل من ٥٠ حرف';
    else return null;
  }

  static String? day(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else if(value.contains('.') || value.contains(',') || value.contains('-') || value.contains('_')) return 'محتوي خاطيء';
    else if(int.parse(value) < 1 || int.parse(value) > 31) return '1 - 31';
    else if (value.length > 2) return 'محتوي خاطيء';
    else return null;
  }

  static String? month(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else if(value.contains('.') || value.contains(',') || value.contains('-') || value.contains('_')) return 'محتوي خاطيء';
    else if(int.parse(value) < 1 || int.parse(value) > 12) return '1 - 12';
    else if (value.length > 2) return 'محتوي خاطيء';
    else return null;
  }

  static String? year(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else if(value.contains('.') || value.contains(',') || value.contains('-') || value.contains('_')) return 'محتوي خاطيء';
    else if(int.parse(value) < 1950 || int.parse(value) > 2020) return '1950 - 2020';
    else if (value.length > 4) return 'محتوي خاطيء';
    else return null;
  }

  static String? comment(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else if(value.length < 2) return 'التعليق يجب ان يكون اكبر من ٢ حرف';
    else return null;
  }

  static String? productTitle(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else if(value.length < 4) return 'العنوان يجب ان يكون اكبر من ٤ احرف';
    else return null;
  }

  static String productDetails(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else if(value.length < 10) return 'التفاصيل يجب ان تكون اكبر من ١٠ احرف';
    else return null!;
  }

  static String? productPrice(String value){
    if(value.isEmpty) return 'حقل فارغ!';
    else return null;
  }

}