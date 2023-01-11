part of 'add_bloc.dart';

@immutable
abstract class AddState {}

class AddInitial extends AddState {}
class  next extends AddState {}
class  empty_state extends AddState {}
