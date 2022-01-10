import 'package:floor/floor.dart';

import 'item.dart';

@dao
abstract class ItemDao {
  @Query('SELECT * FROM Item')
  Future<List<Item>> findAllItems();

  @Query('SELECT * FROM Item WHERE id= :id')
  Stream<Item?> findItemById(int id);

  @insert
  Future<void> insertItem(Item item);

  @update
  Future<int> updateItem(Item item);

  @Query('DELETE FROM Item WHERE id= :id')
  Future<void> deleteItem(int id);
}
