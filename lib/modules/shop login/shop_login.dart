import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/layout.dart';
import 'package:shop_app/modules/shop%20login/cubit/cubit.dart';
import 'package:shop_app/modules/shop%20login/cubit/states.dart';
import 'package:shop_app/modules/shop%20register/cubit/cubit.dart';

import 'package:shop_app/modules/shop%20register/shop_register.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
      if (state is ShopLoginsuccessStates) {
        if (state.loginModel.status!) {
          print(state.loginModel.message);
          print(state.loginModel.data!.token);
          CacheHelper.saveData(
                  value: state.loginModel.data!.token, key: 'token')
              .then((value) {
            navigateAndFinish(context, ShopLayout());
          });
        } else {
          print(state.loginModel.message);
          showToast(text: state.loginModel.message!, states: Toaststates.ERROR);
        }
      }
    }, builder: (context, state) {
      var cubit = ShopLoginCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'login now to browse our hot offers',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defalutFormfeild(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        valdiate: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your email address';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email),
                    const SizedBox(
                      height: 15,
                    ),
                    defalutFormfeild(
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      suffix: ShopRegisterCubit.get(context).suffix,
                      onSubmited: (value) {},
                      ispassword: ShopRegisterCubit.get(context).isPassword,
                      suffixpressed: () {
                        ShopRegisterCubit.get(context)
                            .changePasswordVisibility();
                      },
                      valdiate: (value) {
                        if (value!.isEmpty) {
                          return 'password is too short';
                        }
                      },
                      label: 'Password',
                      prefix: Icons.lock_outline,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                      condition: state is! ShopLoginLoadingStates,
                      builder: (BuildContext context) => defaultButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          text: 'login',
                          isUpperCase: true),
                      fallback: (BuildContext context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('Dont have any account'),
                      defaultTextButton(
                          function: () {
                            navigateTo(context, ShopRegisterScreen());
                          },
                          text: 'register')
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
