import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class CounterInitialized extends CounterEvent {}

class CounterIncrementPressed extends CounterEvent {}

class CounterDecrementPressed extends CounterEvent {}

class CounterMultiplierPressed extends CounterEvent {}

class CounterClearPressed extends CounterEvent {}

class CounterState {
  CounterEvent event;
  int count;
  CounterState(this.event, this.count);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(CounterInitialized(), 0)) {
    on<CounterIncrementPressed>((event, emit) =>
        emit(CounterState(CounterIncrementPressed(), state.count + 1)));
    on<CounterDecrementPressed>((event, emit) =>
        emit(CounterState(CounterDecrementPressed(), state.count - 1)));
    on<CounterMultiplierPressed>((event, emit) =>
        emit(CounterState(CounterMultiplierPressed(), state.count * 2)));
    on<CounterClearPressed>((event, emit) =>
        emit(CounterState(CounterClearPressed(), state.count * 0)));
  }
}
