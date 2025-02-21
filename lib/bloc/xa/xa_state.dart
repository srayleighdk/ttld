import 'package:ttld/models/xa/xa.dart';

abstract class XaState {
  String get message => '';
}

class XaInitial extends XaState {}

class XaLoading extends XaState {}

class XaLoadedByHuyen extends XaState {
  final List<Xa> xas;

  XaLoadedByHuyen({required this.xas});
}

class XaLoaded extends XaState {
  final List<Xa> xas;

  XaLoaded({required this.xas});
}

class XaError extends XaState {
  @override
  final String message;

  XaError({required this.message});
}
