import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/bag_bloc/bag_cubit.dart';
import 'package:flutter_application_1/bloc/detail_bloc/detail_cubit.dart';
import 'package:flutter_application_1/bloc/favorite_bloc/favorite_cubit.dart';
import 'package:flutter_application_1/bloc/search_bloc/search_cubit.dart';
import 'package:flutter_application_1/bloc/shop_bloc/shop_cubit.dart';
import 'package:flutter_application_1/bloc/profile_bloc/profile_cubit.dart';
import 'package:flutter_application_1/data/local/database_servise.dart';
import 'package:flutter_application_1/ui/screens/splash/splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseServise.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ShopCubit>(create: (_) => ShopCubit()),
        BlocProvider<BagCubit>(create: (_) => BagCubit()),
        BlocProvider<ProfileCubit>(create: (_) => ProfileCubit()),
        BlocProvider<DetailCubit>(create: (_) => DetailCubit()),
        BlocProvider<FavoriteCubit>(create: (_) => FavoriteCubit()),
        BlocProvider<SearchCubit>(create: (_) => SearchCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Oila Market',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
