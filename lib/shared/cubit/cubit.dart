import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cash_helper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);
 
  bool isDark = false;
  void changeAppMode( { bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    }else
    isDark = !isDark;
    CachHelper.putBoolean(
      key: "isDark",
      value: isDark,
    ).then((value) {
      emit(AppChangeModeStates());
    });
  }
}
