import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../repository/remote_config.dart';
import '../cubit/my_app_bar_cubit.dart';
import 'view.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyAppBarCubit(context.read<RemoteConfigRepository>()),
      child: const MyAppBarView(),
    );
  }
}
