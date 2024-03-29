import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_app/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterCubit(),
      child: const _CubitCounterView(),
    );
  }
}

class _CubitCounterView extends StatelessWidget {
  const _CubitCounterView();

  @override
  Widget build(BuildContext context) {

    void increaseCounter(BuildContext context, [ int value = 1 ]) {
        context.read<CounterCubit>().increaseCounterByValue(value);
    }

    return Scaffold(
        appBar: AppBar(
            title: context.select((CounterCubit value) => Text('Cubit Counter: ${ value.state.transactionCount }')),
            
            actions: [
                IconButton(
                    onPressed: () {
                        context.read<CounterCubit>().resetCounter();
                    }, 
                    icon: const Icon( Icons.refresh_rounded )
                )
            ],
        ),

        body: Center(
            child: BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                    return Text('Counter value: ${ state.counter }');
                },
            ),
        ),

        floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                FloatingActionButton(
                    heroTag: '1', 
                    child: const Text('+3'), 
                    onPressed: () => increaseCounter(context, 3)
                ),

                const SizedBox(
                    height: 15,
                ),

                FloatingActionButton(
                    heroTag: '2', 
                    child: const Text('+2'), 
                    onPressed: () => increaseCounter(context, 2)
                ),

                const SizedBox(
                    height: 15,
                ),

                FloatingActionButton(
                    heroTag: '3', 
                    child: const Text('+1'), 
                    onPressed: () => increaseCounter(context, 1)
                ),
            ],
        ),
        );
  }
}
