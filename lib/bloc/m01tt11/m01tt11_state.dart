import 'package:equatable/equatable.dart';
import 'package:ttld/models/m01tt11_model.dart';

abstract class M01TT11State extends Equatable {
  const M01TT11State();

  @override
  List<Object> get props => [];
}

class M01TT11Initial extends M01TT11State {}

class M01TT11Loading extends M01TT11State {}

class M01TT11Loaded extends M01TT11State {
  final List<M01TT11> m01tt11s;

  const M01TT11Loaded({required this.m01tt11s});

  @override
  List<Object> get props => [m01tt11s];
}

class M01TT11Error extends M01TT11State {
  final String message;

  const M01TT11Error({required this.message});

  @override
  List<Object> get props => [message];
}
