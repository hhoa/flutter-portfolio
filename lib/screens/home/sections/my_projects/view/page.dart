import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../repository/remote_config.dart';
import '../cubit/my_project_cubit.dart';
import 'view.dart';

class MyProjects extends StatelessWidget {
  const MyProjects({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyProjectCubit(context.read<RemoteConfigRepository>()),
      child: const MyProjectsView(),
    );
  }
}
