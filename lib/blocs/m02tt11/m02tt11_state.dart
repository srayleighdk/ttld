part of 'm02tt11_bloc.dart';

abstract class M02TT11State {}

class M02TT11Initial extends M02TT11State {}

class M02TT11Loading extends M02TT11State {}

class M02TT11ListLoaded extends M02TT11State {
  final List<M02TT11> items;

  M02TT11ListLoaded({required this.items});
}

class M02TT11SingleLoaded extends M02TT11State {
  final M02TT11 item;

  M02TT11SingleLoaded({required this.item});
}

class M02TT11OperationSuccess extends M02TT11State {
  final String message;

  M02TT11OperationSuccess({required this.message});
}

class M02TT11Error extends M02TT11State {
  final String message;

  M02TT11Error({required this.message});
}
