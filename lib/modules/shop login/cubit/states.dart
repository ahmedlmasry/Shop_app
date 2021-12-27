import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialStates extends ShopLoginStates {}

class ShopLoginLoadingStates extends ShopLoginStates {}

class ShopLoginsuccessStates extends ShopLoginStates {
  final ShopLoginModel loginModel;
  ShopLoginsuccessStates(this.loginModel);
}

class ShopLoginErrorStates extends ShopLoginStates {
  final String error;
  ShopLoginErrorStates(this.error);
}

class ShopChangePasswordVisbilityStates extends ShopLoginStates {}
