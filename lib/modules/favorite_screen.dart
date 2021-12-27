import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);

          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesStates,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) => buildFavItem(
                    cubit.favoritesModel!.data!.data![index], context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: cubit.favoritesModel!.data!.data!.length),
            fallback: (BuildContext context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget buildFavItem(
    DataFavorites model,
    context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.product!.image!.toString()),
                    width: 120,
                    height: 120,
                    // fit: BoxFit.cover,
                  ),
                  if (model.product!.discount != 0)
                    Container(
                      color: Colors.black,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.product!.name!.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, height: 2),
                    ),
                    const Spacer(),
                    Row(children: [
                      Text(
                        '${model.product!.price.round()}',
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.3,
                          color: defaultcolor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.product!.discount != 0)
                        Text(
                          '${model.product!.oldPrice.round()}',
                          style: const TextStyle(
                              fontSize: 10,
                              height: 1.3,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model.product!.id);
                          },
                          icon: CircleAvatar(
                              radius: 15.0,
                              backgroundColor: ShopCubit.get(context)
                                      .favorites[model.product!.id]!
                                  ? defaultcolor
                                  : Colors.grey,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              )))
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
