import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/remote_config.dart';
import '../cubit/home_cubit.dart';
import 'view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(context.read<RemoteConfigRepository>()),
      child: const HomeView(),
    );
  }
}
