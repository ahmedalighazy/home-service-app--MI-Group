import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service_app/core/di/injection.dart';
import 'package:home_service_app/features/address/presentation/cubit/address_cubit.dart';
import 'package:home_service_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:home_service_app/features/home/presentation/pages/home_cotent.dart';
import 'package:home_service_app/features/notification/presentation/cubit/notification_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()),
        BlocProvider(create: (context) => getIt<AddressCubit>()),
        BlocProvider(create: (context) => getIt<NotificationCubit>()),
      ],
      child: const Scaffold(
        body: HomeContent(),
      ),
    );
  }
}
