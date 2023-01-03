part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();
}

class AccountInitial extends AccountState {
  @override
  List<Object> get props => [];
}
class app_check extends AccountState {
  @override
  List<Object> get props => [];
}
class is_login_state extends AccountState {
  user_models user;
  is_login_state(this.user);

  @override
  List<Object> get props => [];
}
class is_not_login_state extends AccountState {
  @override
  List<Object> get props => [];
}


class error_login_state extends AccountState {
  @override
  List<Object> get props => [];
}



