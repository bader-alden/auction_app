import '../../models/main_list_model.dart';

abstract class main_state{}
class init extends main_state{}
class nav_bar_state extends main_state{}
class get_main_list_state extends main_state{
  List<main_list_model> list;

  get_main_list_state(this.list);
}
class loading_main_list_state extends main_state{}
class sort_state extends main_state{}

