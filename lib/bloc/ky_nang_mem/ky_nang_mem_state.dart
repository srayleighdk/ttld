part of 'ky_nang_mem_bloc.dart';

abstract class KyNangMemState extends Equatable {
  const KyNangMemState();

  @override
  List<Object> get props => [];
}

class KyNangMemInitial extends KyNangMemState {}

class KyNangMemLoading extends KyNangMemState {}

class KyNangMemLoaded extends KyNangMemState {
  final List<KyNangMemModel> kyNangMems;

  const KyNangMemLoaded(this.kyNangMems);

  @override
  List<Object> get props => [kyNangMems];
}

class KyNangMemOperationSuccess extends KyNangMemState {} // For Add/Update/Delete success feedback

class KyNangMemError extends KyNangMemState {
  final String message;

  const KyNangMemError(this.message);

  @override
  List<Object> get props => [message];
}
