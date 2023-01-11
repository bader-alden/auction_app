part of 'fav_bloc.dart';

@immutable
abstract class FavEvent {}
class check_is_fav extends FavEvent{
  final type;
  final id;

  check_is_fav(this.type, this.id);
}
class add_to_fav extends FavEvent{
  final type;
  final id;

  add_to_fav(this.type, this.id);
}
class fav_evint extends FavEvent{
  final type;

  fav_evint(this.type);
}
