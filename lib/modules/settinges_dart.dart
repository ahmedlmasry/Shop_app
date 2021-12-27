import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/shop%20login/shop_login.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/endpoints.dart';

class SettingesScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
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
                            return 'Email must not be empty';
                          }
                        },
                        label: 'Email Address',
                        prefix: Icons.email),
                    const SizedBox(
                      height: 20,
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
                    defaultButton(
                        function: () {
                          if (formkey.currentState!.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'Update'),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          CacheHelper.removeData(key: 'token').then((value) {
                            navigateAndFinish(context, ShopLoginScreen());
                          });
                        },
                        text: 'Logout')
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
