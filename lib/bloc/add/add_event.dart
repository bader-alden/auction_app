part of 'add_bloc.dart';

@immutable
abstract class AddEvent {}
class add_event{
  final my_id;
  final name;
  final des;
  final price;
  final min_price;
  final num_day;
  final city;
  final type;

  add_event(this.my_id, this.name, this.des, this.price, this.min_price, this.num_day, this.city, this.type);
}