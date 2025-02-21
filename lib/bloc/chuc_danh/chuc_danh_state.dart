import 'package:ttld/models/chuc_danh_model.dart';

abstract class ChucDanhState {
  const ChucDanhState();
}

class ChucDanhInitial extends ChucDanhState {
  const ChucDanhInitial();
}

class ChucDanhLoading extends ChucDanhState {
  const ChucDanhLoading();
}

class ChucDanhLoaded extends ChucDanhState {
  const ChucDanhLoaded(this.chucDanhs);

  final List<ChucDanhModel> chucDanhs;
}

class ChucDanhError extends ChucDanhState {
  const ChucDanhError(this.message);

  final String message;
}
