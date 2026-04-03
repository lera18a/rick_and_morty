import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/core/errors/error_type.dart';
import 'package:rick_and_morty/core/errors/error_handler.dart';
import 'package:rick_and_morty/domain/entity/list_entity.dart';
import 'package:rick_and_morty/domain/repository/repository.dart';

part 'liked_state.dart';

class LikedCubit extends Cubit<LikedState> {
  final Repository _repository;
  late final StreamSubscription<int> _likeSub;
  LikedCubit({required Repository repository})
    : _repository = repository,
      super(LikedInitial()) {
    _likeSub = _repository.likeUpdates.listen((_) => load(showLoading: false));
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

  Future<void> load({bool showLoading = true}) async {
    if (showLoading) emit(LikedLoading());
    try {
      final listEntities = await _repository.getLiked();
      emit(LikedLoaded(listEntities: listEntities));
    } catch (e) {
      final errorType = ErrorHandler.handleError(e);
      emit(LikedError(message: errorType.message, errorType: errorType));
    }
  }
}
