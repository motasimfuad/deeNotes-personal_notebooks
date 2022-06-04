import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dependency_injection.dart';
import 'features/notebook/presentation/bloc/notebook_bloc.dart';

class AllProviders extends StatelessWidget {
  final Widget child;
  const AllProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotebookBloc>(
          create: (context) => getIt<NotebookBloc>(),
        ),
      ],
      child: child,
    );
  }
}
