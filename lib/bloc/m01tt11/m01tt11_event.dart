import 'package:equatable/equatable.dart';
import 'package:ttld/models/m01tt11_model.dart';

abstract class M01TT11Event extends Equatable {
  const M01TT11Event();

  @override
  List<Object> get props => [];
}

class M01TT11LoadAll extends M01TT11Event {}

class M01TT11Create extends M01TT11Event {
  final M01TT11 m01tt11;

  const M01TT11Create({required this.m01tt11});

  @override
  List<Object> get props => [m01tt11];
}

class M01TT11Update extends M01TT11Event {
  final String id;
  final M01TT11 m01tt11;

  const M01TT11Update({required this.id, required this.m01tt11});

  @override
  List<Object> get props => [id, m01tt11];
}

class M01TT11Delete extends M01TT11Event {
  final String id;

  const M01TT11Delete({required this.id});

  @override
  List<Object> get props => [id];
}
