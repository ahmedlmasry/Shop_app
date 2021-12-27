import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/searsh_model.dart';
import 'package:shop_app/modules/searsh%20screen/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';

class SearshCubit extends Cubit<SearshStates> {
  SearshCubit() : super(SearshInitialStates());
  static SearshCubit get(context) => BlocProvider.of(context);

  SearshModel? model;
  void getSearsh(String text) {
    emit(SearshLoadingStates());

    DioHelper.postData(url: SEARSH, data: {'text': text}, token: token)
        .then((value) {
      model = SearshModel.fromJson(value.data);
      emit(SearshSuccessStates());
    }).catchError((error) {
      emit(SearshErrorStates());
    });
  }
}
