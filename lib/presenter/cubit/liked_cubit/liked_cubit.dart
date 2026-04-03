import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/errors/handle_exception.dart';
import 'package:rick_and_morty/data/mapper.dart';
import 'package:rick_and_morty/data/repository_impl.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  final RepositoryImpl _repository;
  late final StreamSubscription<int> _likeSub;
  LikedCubit({required RepositoryImpl repository})
    : _repository = repository,
      super(LikedInitial()) {
    _likeSub = _repository.likeUpdates.listen((_) => load());
  }

  @override
  Future<void> close() {
    _likeSub.cancel();
    return super.close();
  }

  Future<void> cleanCache() async {
    await _repository.clearCache();
    await load();
  }

  Future<void> load() async {
    emit(LikedLoading());
    try {
      final listEntities = await _repository.getLiked();
      final entites = listEntities.map((data) => Mapper.toList(data)).toList();
      emit(LikedLoaded(listEntities: entites));
    } catch (e) {
      final errorType = ErrorHandler.handleError(e);
      emit(LikedError(message: errorType.message, errorType: errorType));
    }
  }

  Future<void> toggleLike(int id) async {
    try {
      // final character = await _repository.getByID(id);
      // if (character == null) return;
      await _repository.toggleLike(id);
    } catch (e) {
      final errorType = ErrorHandler.handleError(e);
      emit(LikedError(message: errorType.message, errorType: errorType));
    }
  }
}
