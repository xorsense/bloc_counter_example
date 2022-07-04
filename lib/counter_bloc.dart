import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class CounterInitialized extends CounterEvent {}

class CounterIncrementPressed extends CounterEvent {}

class CounterDecrementPressed extends CounterEvent {}

class CounterMultiplierPressed extends CounterEvent {}

class CounterClearPressed extends CounterEvent {}

class CounterErr extends CounterEvent {
  String get message => 'there was an error in the value of the counter';
}

class CounterErrDoublingZero extends CounterErr {
  @override
  String get message => '0 cannot be doubled';
}

class CounterErrClearingZero extends CounterErr {
  @override
  String get message => '0 cannot be cleared';
}

class CounterState {
  CounterEvent event;
  int count = 0;
  String message = '';
  bool isError = false;
  CounterState(this.event, this.count);
  CounterState.withError(this.event, CounterState? previousState) {
    if (previousState != null) count = previousState.count;
    message = (event as CounterErr).message;
    isError = true;
  }
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(CounterInitialized(), 0)) {
    on<CounterIncrementPressed>((event, emit) =>
        emit(CounterState(CounterIncrementPressed(), state.count + 1)));
    on<CounterDecrementPressed>((event, emit) =>
        emit(CounterState(CounterDecrementPressed(), state.count - 1)));
    on<CounterMultiplierPressed>((event, emit) => {
          emit(state.count == 0
              ? CounterState.withError(CounterErrDoublingZero(), state)
              : CounterState(CounterMultiplierPressed(), state.count * 2))
        });
    on<CounterClearPressed>((event, emit) => {
          emit(state.count == 0
              ? CounterState.withError(CounterErrClearingZero(), state)
              : CounterState(CounterClearPressed(), state.count * 0))
        });
  }
}
