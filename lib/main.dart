import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/layout.dart';
import 'package:shop_app/modules/on%20boarding/on_boarding.dart';
import 'package:shop_app/modules/searsh%20screen/cubit/cubit.dart';
import 'package:shop_app/modules/shop%20login/cubit/cubit.dart';

import 'package:shop_app/modules/shop%20login/shop_login.dart';
import 'package:shop_app/modules/shop%20register/cubit/cubit.dart';
import 'package:shop_app/modules/shop%20register/shop_register.dart';
import 'package:shop_app/shared/components/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/themes.dart';

import 'shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);

  Widget widget;

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserData(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopRegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopLoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SearshCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        home: OnBoardingScreen(),
      ),
    );
  }
}
