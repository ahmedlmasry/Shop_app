import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/cateogries_model.dart';
import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/cateogries_screen.dart';
import 'package:shop_app/modules/favorite_screen.dart';
import 'package:shop_app/modules/products_screen.dart';
import 'package:shop_app/modules/settinges_dart.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopIntialStates());
  static ShopCubit get(context) => BlocProvider.of(context);

  int currenindex = 0;

  List<Widget> bottomScreens = [
    const HomeScreen(),
    const CateogriesScreen(),
    const FavoritesScreen(),
    SettingesScreen()
  ];

  void ChangeIndex(int index) {
    currenindex = index;
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    DioHelper.getData(url: HOME).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      //  print(favorites.toString());

      emit(ShopSuccessHomeDataStates());
    }).catchError((error) {
      emit(ShopErrorHomeDataStates());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesStates());
    }).catchError((error) {
      emit(ShopErrorCategoriesStates());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesStates());
    DioHelper.postData(
            url: 'favorites',
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromjson(value.data);
      // print(value.data);
      if (!changeFavoriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesStates(changeFavoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesStates());
    });
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoritesStates());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      //print(value.data);
      emit(ShopSuccessGetFavoritesStates());
    }).catchError((error) {
      emit(ShopErrorGetFavoritesStates());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingGetUserDataStates());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      //  print(value.data);
      emit(ShopSuccessGetUserDataStates(userModel!));
    }).catchError((error) {
      emit(ShopErrorGetUserDataStates());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      // print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisbility() {
    // suffix = Icons.visibility_off_outlined;
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.verified_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisbilityStates());
  }
}
