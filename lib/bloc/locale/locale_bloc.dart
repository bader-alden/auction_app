import 'dart:io';
import 'package:auction_app/cache.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'locale_event.dart';
part 'locale_state.dart';
enum mode  {ar,en}
class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {

  LocaleBloc() : super(LocaleState(Platform.localeName.contains("en") ? "en":"ar")) {
   change_local_void();
  }
  void change_local_void() {
    if(cache.get_data("locale") == "ar"){
      emit(LocaleState("ar"));
    }
   else if(cache.get_data("locale") == "en"){
      emit(LocaleState("en"));
    }
    else{
      Platform.localeName.contains("en")
          ? emit(LocaleState("en"))
          : emit(LocaleState("ar"));
    }
  }
  var lang = cache.get_data("locale") == "system"
      ?Platform.localeName.contains("en")
      :cache.get_data("locale") == "en";
  String get home_page_middle => lang ? "Offers" : "العروض";
  String get home_page_sqr_buttumn => lang ? "Go to Auction" : "الذهاب إلى المزايدة";
  String get home_page_sqr_top => lang ? "Type of Auction : " : "نوع المزاد : ";
  String get home_page_sqr_down => lang ? "current price" : "السعر الحالي : ";
  String get curunce => lang ? " SAR" : " ر.س ";
  String get test2_id => lang ? "Lot #" : "الرقم التسلسلي #";
  String get second => lang ? "s" : "ث";
  String get hour => lang ? "h" : "س";
  String get minutes => lang ? "m" : "د";
  String get day => lang ? "d" : "ي";
  String get q => lang ? "your rank" : "ترتيبك هو";
  String get a => lang ? "number of baids" : "عدد المزايدين";
  String get z => lang ? "Current Price" : "السعر الحالي";
  String get w => lang ? "end in" : "ينتهي في";
  String get s => lang ? "Min increment" : "أقل مزايدة";
  String get x => lang ? "your baid" : "لقد دفعت";
  String get test2_end => lang ? "Place a bid" : "مزايدة";
  String get not => lang ? "not in" : "لم تشارك";
  String get of => lang ? " of " : " من ";
  String get range => lang ? "select the price range" :"أختر رنج السعر";
  String get city => lang ? "select the city" :"أختر المدينة";
  String get apply => lang ? "apply" :"تطبيق";
  String get remove => lang ? "remove" :"حذف";
  String get price => lang ? "price" :"السعر";
  String get city_str => lang ? "city" :"المدينة";
  String get dirct_sele => lang ? "direct sale" :"بيع مباشر";
  String get time_lift => lang ? "Time Left " :"الوقت المتبقي";
  String get welcom => lang ? "Welcome Back ! " :"أهلا بعودتك";
  String get terms => lang ? "Terms and Condition " :"سياسة الاستخدام";
  String get faq => lang ? "F A Q  " :"الأسئلة المكررة";
  String get help => lang ? "Help " :"المساعدة";
  String get log_out => lang ? "Log Out " :"تسجيل الخروج";
  String get setting => lang ? "Setting " :"إعدادات التطبيق";
}
