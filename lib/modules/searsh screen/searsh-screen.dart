import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/searsh_model.dart';
import 'package:shop_app/modules/searsh%20screen/cubit/cubit.dart';
import 'package:shop_app/modules/searsh%20screen/cubit/states.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';

class SearshScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var searshContorller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearshCubit, SearshStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SearshCubit.get(context);
        return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    defalutFormfeild(
                        controller: searshContorller,
                        type: TextInputType.text,
                        valdiate: (value) {
                          if (value!.isEmpty) {
                            return 'searsh must not be empty';
                          }
                        },
                        label: 'searsh',
                        prefix: Icons.search,
                        onSubmited: (text) {
                          SearshCubit.get(context).getSearsh(text);
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearshLoadingStates)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (state is SearshSuccessStates)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                                cubit.model!.data!.data![index], context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: cubit.model!.data!.data!.length),
                      ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
