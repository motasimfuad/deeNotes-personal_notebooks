import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

import '../../../notebook/presentation/bloc/notebook_bloc.dart';

class FavoriteNotesPage extends StatefulWidget {
  const FavoriteNotesPage({Key? key}) : super(key: key);

  @override
  State<FavoriteNotesPage> createState() => _FavoriteNotesPageState();
}

class _FavoriteNotesPageState extends State<FavoriteNotesPage> {
  // ignore: unused_field
  List<NotebookEntity> _notebooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Favorite Notes'),
        elevation: 0,
      ),
      body: BlocConsumer<NotebookBloc, NotebookState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NotebookListLoaded) {
            _notebooks = state.notebooks;
          }
          return Column(
            children: [
              Container(),
            ],
          );
        },
      ),
    );
  }
}
