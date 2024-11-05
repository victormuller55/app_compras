import 'package:aula_01/models/item_model.dart';
import 'package:muller_package/models/error_model.dart';

abstract class State {
  ErrorModel errorModel;
  List<ItemModel> items;
  double total;

  State({required this.items, required this.errorModel, required this.total});
}

class InitialState extends State {
  InitialState() : super(total: 0, items: [], errorModel: ErrorModel.empty());
}

class LoadingState extends State {
  LoadingState() : super(total: 0, items: [], errorModel: ErrorModel.empty());
}

class SuccessState extends State {
  SuccessState({required super.items, required super.total}) : super(errorModel: ErrorModel.empty());
}

class ErrorState extends State {
  ErrorState({required super.errorModel}) : super(items: [], total: 0);
}