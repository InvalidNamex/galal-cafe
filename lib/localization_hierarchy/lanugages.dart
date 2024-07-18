import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar_EG': {
          'Language': 'اللغة',
          'Auto-resolution timed out...': 'انتهت مهلة انتظار الرسالة',
          'The provided phone number is not valid.': 'رقم الهاتف غير صحيح',
          'Enter SMS Code': 'ادخل الكود',
          'SMS Code': 'كود الرسالة',
          'Verify': 'تأكيد',
          'Please enter your phone number': '',
          'Phone Number': 'رقم الهاتف',
          'Please enter a valid 11-digit phone number': '',
          'Enter your phone number': '',
          'Good morning': 'صباح الخير',
          'Good afternoon': 'مساء الخير',
          'Good evening': 'مساء الخير',
          'Good night': 'مساء الخير',
          'Size': 'الحجم',
          'Select a flavor': 'اختر نكهة',
          'Flavor': 'النكهة',
          'Roast': 'التحميص',
          'Sugar': 'السكر',
          'add to cart': 'أضف إلى السلة',
          'Log out': 'تسجيل خروج',
          'item added': 'تمت الإضافة',
          'Delete': 'حذف',
          'Empty Cart': 'سلة فارغة',
          'Try again later': 'حاول مرة أخرى',
          'Ready to checkout?': 'جاهز تنفذ الطلب؟',
          'Your cart is empty': 'سلة مشترياتك فارغة'
        },
      };
  static bool get isArabic => Get.locale?.languageCode == 'ar';
}
