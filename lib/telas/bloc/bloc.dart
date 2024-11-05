import 'package:aula_01/models/item_model.dart';
import 'package:aula_01/telas/bloc/events.dart';
import 'package:aula_01/telas/bloc/states.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class AppBloc extends Bloc<Event, State> {
  AppBloc() : super(InitialState()) {
    on<AdicionarEvent>((event, emit) async {
      emit(LoadingState());
      try {
        event.items.add(event.item);

        double total = 0;

        for (ItemModel item in event.items) {
          total += item.value;
        }

        emit(SuccessState(items: event.items, total: total));
        showSnackbarSuccess(message: "Adicionado Com Sucesso");
      } catch (e) {
        emit(ErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });

    on<RemoverEvent>((event, emit) async {
      emit(LoadingState());
      try {

        event.items.remove(event.item);

        double total = 0;

        for (ItemModel item in event.items) {
          total += item.value;
        }

        emit(SuccessState(items: event.items, total: total));
        showSnackbarSuccess(message: "Removido Com Sucesso");
      } catch (e) {
        emit(ErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}
