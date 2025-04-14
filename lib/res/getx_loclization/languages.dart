

import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {

  @override
  Map<String , Map<String, String>> get keys => {
    'en_US' : {
      'email_hint' : 'Email' ,
      'internet_exception' : "We're unable tp show results.\nPlease check your data\nconenction." ,
      'general_exception' : "We're unable to process your request.\n Please try again" ,
      'welcome_back' : 'Welcome\nBack' ,
      'login' :'Login' ,
      'password_hint' :'Password' ,
    },
    'ar_IQ' : {
      'email_hint' : 'الايميل' ,
      'internet_exception' : "تحقق من اتصالك بلانترنت" ,
      'general_exception' : "حدث خطا اثناء عملية جلب البيانات" ,
      'welcome_back' : 'Welcome\nBack' ,
      'login' :'تسجيل دخ،ل' ,
      'password_hint' :'كلمة السر' ,
    },

  };
}