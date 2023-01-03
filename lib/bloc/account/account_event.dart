part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();
  @override
  List<Object?> get props => [];
}

class Accountlodaded extends AccountEvent {
  @override
  List<Object?> get props => [];
}

class login_event extends AccountEvent {
  final email;
  final token;

  login_event(this.email, this.token);
  @override
  List<Object?> get props => [];
}

class logout_event extends AccountEvent {
  @override
  List<Object?> get props => [];
}
class register_event extends AccountEvent{
  final name;
  final email;
  final token;
  final numb;

  register_event(this.name, this.email, this.numb, this.token);

  @override
  List<Object?> get props => [];
}
