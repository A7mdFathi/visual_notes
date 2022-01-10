import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:visual_notes/local/app_database.dart';
import 'package:visual_notes/local/item.dart';
import 'package:visual_notes/utils/app_logger.dart';

part 'items_event.dart';

part 'items_state.dart';

enum ItemType { edit, add }

@injectable
class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  ItemsBloc(this._appDatabase, this._appLogger) : super(ItemsInitial()) {
    on<ItemsFetched>(_mapItemsToState);
    on<SaveItem>(_mapSavedItemToState);
    on<DeleteItem>(_mapDeleteToState);
  }

  final AppDatabase _appDatabase;
  final AppLogger _appLogger;

  _mapItemsToState(ItemsEvent event, Emitter<ItemsState> emit) async {
    emit(ItemsLoadInProgress());

    try {
      final items = await _appDatabase.itemDao.findAllItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemsFailure('$e'));
      _appLogger.error(e);
      rethrow;
    }
  }

  _mapSavedItemToState(SaveItem event, Emitter<ItemsState> emit) async {
    emit(ItemsLoadInProgress());

    try {
      if (event.itemType == ItemType.add) {
        await _appDatabase.itemDao.insertItem(event.item);
      } else {
        final int rowChange = await _appDatabase.itemDao.updateItem(event.item);
        _appLogger.info('ROW CHANGE $rowChange');
      }
      add(ItemsFetched());
    } catch (e) {
      rethrow;
    }
  }

  _mapDeleteToState(DeleteItem event, Emitter<ItemsState> emit) {
    emit(ItemsLoadInProgress());
    try {
      _appDatabase.itemDao.deleteItem(event.id);
      add(ItemsFetched());
    } catch (e) {
      rethrow;
    }
  }
}
