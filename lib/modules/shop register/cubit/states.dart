import 'package:shop_app/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterIntialStates extends ShopRegisterStates {}

class ShopRegisterLoadingStates extends ShopRegisterStates {}

class ShopRegistersuccessStates extends ShopRegisterStates {
  final ShopLoginModel LoginModel;
  ShopRegistersuccessStates(this.LoginModel);
}

class ShopRegisterErrorStates extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorStates(this.error);
}

class ShopRegisterChangePasswordVisbilityStates extends ShopRegisterStates {}
