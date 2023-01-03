part of 'locale_bloc.dart';

@immutable
abstract class LocaleEvent {}
class init_local_state extends LocaleEvent{}

class change_local_state extends LocaleEvent{}
