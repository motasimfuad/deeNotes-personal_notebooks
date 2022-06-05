import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/router/app_router.dart';

import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';
import 'package:notebooks/features/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_persistent_header.dart';

import '../../../note/presentation/widgets/note_item.dart';

class NoteBookPage extends StatefulWidget {
  NotebookEntity? notebook;
  int notebookId;
  NoteBookPage({
    Key? key,
    this.notebook,
    required this.notebookId,
  }) : super(key: key);

  @override
  State<NoteBookPage> createState() => _NoteBookPageState();
}

class _NoteBookPageState extends State<NoteBookPage> {
  NotebookEntity? notebookEntity;
  List<NoteEntity> notes = [];

  @override
  void initState() {
    context.read<NotebookBloc>().add(FindNotebookEvent(widget.notebookId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<NotebookBloc, NotebookState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NotebookLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NotebookLoaded) {
              notebookEntity = state.notebook;

              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: NotebookPersistentHeader(
                      notebook: notebookEntity as NotebookEntity,
                      expandedHeight: 250.h,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: notes.isEmpty
                        ? SizedBox(
                            height: 300.h,
                            child: Center(
                              child: Text(
                                'No notes found!',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        : Stack(
                            children: [
                              Align(
                                alignment: Alignment(1, 10.h),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 20.w,
                                    right: 20.h,
                                    bottom: 20.h,
                                    top: 0.h,
                                    // top: 10.h,
                                  ),
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 1,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15.w,
                                        mainAxisSpacing: 15.h,
                                      ),
                                      // itemCount: notebook.notes?.length,
                                      itemCount: notes.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var selectedNote = notes[index];
                                        return GestureDetector(
                                          // onTap: () => Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         ViewNoteScreen(
                                          //       notebook: notebook,
                                          //       note: selectedNote,
                                          //     ),
                                          //   ),
                                          // ),
                                          child: NoteItem(note: selectedNote),
                                        );
                                      }),
                                ),
                              ),
                            ],
                          ),
                  )
                ],
              );
            }
            return const Center(
              child: Text('No notebook'),
            );
          },
        ),
        floatingActionButton: KFab(
          label: 'New Note',
          icon: Icons.post_add,
          onPressed: () {
            router.pushNamed(
              AppRouters.createNotePage,
              params: {
                'notebookId': widget.notebookId.toString(),
              },
            );
          },
        ),
      ),
    );
  }
}
