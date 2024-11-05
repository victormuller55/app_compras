import 'package:aula_01/models/item_model.dart';

abstract class Event {}

class AdicionarEvent extends Event {
  ItemModel item;
  List<ItemModel> items;
  AdicionarEvent(this.item, this.items);
}

class RemoverEvent extends Event {
  ItemModel item;
  List<ItemModel> items;
  RemoverEvent(this.item, this.items);
}