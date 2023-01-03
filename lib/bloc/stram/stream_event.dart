part of 'stream_bloc.dart';

abstract class StreamEvent extends Equatable {
  const StreamEvent();
}
class init_stream extends StreamEvent{
  @override
  List<Object?> get props => [];
}
class get_one_event extends StreamEvent{
  final id;
  get_one_event(this.id);
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
