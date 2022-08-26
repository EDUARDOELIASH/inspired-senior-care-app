import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'response_deck_state.dart';

class ResponseDeckCubit extends Cubit<ResponseDeckState> {
  ResponseDeckCubit() : super(ResponseDeckState.initial());
  void scrollDeck(int index) async {
    emit(ResponseDeckState.scrolled(index));
    print(index);
    emit(ResponseDeckState.stopped(index));
  }
}
