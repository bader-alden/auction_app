part of 'stream_bloc.dart';

abstract class StreamState extends Equatable {
  const StreamState();
}

class StreamInitial extends StreamState {
  @override
  List<Object> get props => [];
}
class scss_init_stream_state extends StreamState{

  @override
  List<Object?> get props => [];
}

class faild_init_stream_state extends StreamState{

  @override
  List<Object?> get props => [];
}
class loading_init_stream_state extends StreamState{

  @override
  List<Object?> get props => [];
}
class scss_list_auction_state extends StreamState{

  @override
  List<Object?> get props => [];
}

class faild_list_auction_state extends StreamState{

  @override
  List<Object?> get props => [];
}
class loading_list_auction_state extends StreamState{

  @override
  List<Object?> get props => [];
}
class disconect_state extends StreamState{

  @override
  List<Object?> get props => [];
}
