part of 'm02tt11_bloc.dart';

abstract class M02TT11Event {}

class LoadM02TT11List extends M02TT11Event {
  final String userId;

  LoadM02TT11List({required this.userId});
}

class LoadM02TT11ById extends M02TT11Event {
  final String id;

  LoadM02TT11ById({required this.id});
}

class CreateM02TT11 extends M02TT11Event {
  final M02TT11 data;

  CreateM02TT11({required this.data});
}

class UpdateM02TT11 extends M02TT11Event {
  final String id;
  final M02TT11 data;

  UpdateM02TT11({required this.id, required this.data});
}

class DeleteM02TT11 extends M02TT11Event {
  final String id;

  DeleteM02TT11({required this.id});
}
