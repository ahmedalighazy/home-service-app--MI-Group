import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    // ignore: avoid_print
    print("---------onChange ${bloc.runtimeType},$change");
  }

  @override
  void onClose(BlocBase bloc) {
    // ignore: avoid_print
    print("---------onClose ${bloc.runtimeType}");
  }

  @override
  void onCreate(BlocBase bloc) {
    // ignore: avoid_print
    print("---------oncreate ${bloc.runtimeType}");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {

  }

  @override
  void onEvent(Bloc bloc, Object? event) {

  }

  @override
  void onTransition(Bloc bloc, Transition transition) {

  }
}
