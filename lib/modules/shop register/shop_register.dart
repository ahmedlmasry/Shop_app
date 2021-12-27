import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/layout/layout.dart';
import 'package:shop_app/modules/shop%20register/cubit/cubit.dart';
import 'package:shop_app/modules/shop%20register/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
          listener: (context, state) {
        if (state is ShopRegistersuccessStates) {
          if (state.LoginModel.status!) {
            print(state.LoginModel.message);
            print(state.LoginModel.data!.token);
            showToast(
                text: state.LoginModel.message!, states: Toaststates.SUCESS);
            CacheHelper.saveData(
                    value: state.LoginModel.data!.token, key: 'token')
                .then((value) {
              navigateAndFinish(context, ShopLayout());
            });
          } else {
            print(state.LoginModel.message);
            showToast(
                text: state.LoginModel.message!, states: Toaststates.ERROR);
          }
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Register now to browse our hot offers',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      defalutFormfeild(
                          controller: nameController,
                          type: TextInputType.name,
                          valdiate: (value) {
                            if (value!.isEmpty) {
                              return 'Name must not be empty';
                            }
                          },
                          label: 'Name',
                          prefix: Icons.person),
                      const SizedBox(
                        height: 20,
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
                          suffix: ShopRegisterCubit.get(context).suffix,
                          onSubmited: (value) {},
                          ispassword: ShopRegisterCubit.get(context).isPassword,
                          suffixpressed: () {
                            ShopRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          type: TextInputType.visiblePassword,
                          valdiate: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your password';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline),
                      const SizedBox(
                        height: 15,
                      ),
                      defalutFormfeild(
                          controller: phoneController,
                          type: TextInputType.phone,
                          valdiate: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingStates,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formkey.currentState!.validate()) {
                              ShopRegisterCubit.get(context).UserRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'register',
                          isUpperCase: true,
                        ),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
