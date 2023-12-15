import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ibloc_event.dart';
part 'ibloc_state.dart';

class IblocBloc extends Bloc<IblocEvent, IblocState> {
  IblocBloc() : super(IblocInitial()) {
    on<IblocEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
