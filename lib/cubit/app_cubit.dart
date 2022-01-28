import 'package:bloc/bloc.dart';
import 'package:earthquake_app/cubit/app_cutibt_state.dart';
import 'package:earthquake_app/data_service/data_service.dart';
import 'app_cutibt_state.dart';

class AppCubit extends Cubit<CubitState> {
  AppCubit({required this.data}) : super(InitialState()) {
    getData();
  }
  final DataService data;
  late final httpData;
  Future<void> getData() async {
    try {
      emit(LoadingState());
      httpData = await data.getInfo();
      emit(LoadedState(httpData: httpData));
    } catch (e) {
      print(e);
    }
  }
}
