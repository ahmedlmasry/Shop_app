import 'package:shop_app/models/change_favorite_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopStates {}

class ShopIntialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {}

class ShopSuccessCategoriesStates extends ShopStates {}

class ShopErrorCategoriesStates extends ShopStates {}

class ShopSuccessChangeFavoritesStates extends ShopStates {
  final ChangeFavoriteModel model;
  ShopSuccessChangeFavoritesStates(this.model);
}

class ShopErrorChangeFavoritesStates extends ShopStates {}

class ShopChangeFavoritesStates extends ShopStates {}

class ShopLoadingGetFavoritesStates extends ShopStates {}

class ShopSuccessGetFavoritesStates extends ShopStates {}

class ShopErrorGetFavoritesStates extends ShopStates {}

class ShopLoadingGetUserDataStates extends ShopStates {}

class ShopSuccessGetUserDataStates extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessGetUserDataStates(this.loginModel);
}

class ShopErrorGetUserDataStates extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopLoginModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}

class ShopChangePasswordVisbilityStates extends ShopStates {}
