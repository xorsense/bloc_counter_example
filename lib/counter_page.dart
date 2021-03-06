import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocListener<CounterBloc, CounterState>(
        listener: ((context, counterState) {
          var snackBar = ScaffoldMessenger.of(context);
          if (counterState.isError) {
            snackBar.showSnackBar(
              SnackBar(
                content: Text(counterState.message),
              ),
            );
          }
        }),
        child: BlocBuilder<CounterBloc, CounterState>(
          builder: (context, counterState) {
            return Center(
              child: Text(
                '${counterState.count}',
                style: const TextStyle(fontSize: 24.0),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  context.read<CounterBloc>().add(CounterIncrementPressed()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () =>
                  context.read<CounterBloc>().add(CounterDecrementPressed()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.clear),
              onPressed: () =>
                  context.read<CounterBloc>().add(CounterMultiplierPressed()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              child: const Icon(Icons.delete_outline),
              onPressed: () =>
                  context.read<CounterBloc>().add(CounterClearPressed()),
            ),
          )
        ],
      ),
    );
  }
}
