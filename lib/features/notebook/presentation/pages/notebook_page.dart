import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notebooks/core/router/app_router.dart';

import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/core/widgets/k_snackbar.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';
import 'package:notebooks/features/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_persistent_header.dart';

import '../../../../core/constants/constants.dart';
import '../../../note/presentation/bloc/note_bloc.dart';
import '../../../note/presentation/widgets/note_item.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';

class NoteBookPage extends StatefulWidget {
  final NotebookEntity? notebook;
  final int notebookId;
  const NoteBookPage({
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
  int totalFavorites = 0;
  NoteViewType gridView = NoteViewType.grid;
  NoteViewType listView = NoteViewType.list;
  NoteViewType noteViewType = NoteViewType.grid;
  bool noteContentIsHidden = false;

  @override
  void initState() {
    context.read<NotebookBloc>().add(FindNotebookEvent(widget.notebookId));
    context.read<NoteBloc>().add(
          GetAllNotesEvent(notebookId: widget.notebookId),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<NotebookBloc, NotebookState>(
          listener: (context, state) {
            if (state is NotebookLoaded) {
              notebookEntity = state.notebook;
            }

            if (state is NotebookUpdated) {
              BlocProvider.of<NotebookBloc>(context)
                  .add(const GetAllNotebooksEvent());
            }
          },
          builder: (context, state) {
            if (state is NotebookLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NotebookLoaded) {
              notebookEntity = state.notebook;
            }
            return SizedBox(
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state is NoteCreated) {
                    context.read<NoteBloc>().add(
                          GetAllNotesEvent(notebookId: widget.notebookId),
                        );
                  }
                  if (state is NotesListLoaded) {
                    notes = state.notes;
                    totalFavorites = notes
                        .where((element) => element.isFavorite == true)
                        .toList()
                        .length;
                  }

                  return CustomScrollView(
                    slivers: [
                      BlocBuilder<NotebookBloc, NotebookState>(
                        builder: (context, state) {
                          if (state is NotebookLoaded ||
                              notebookEntity != null) {
                            return SliverPersistentHeader(
                              delegate: NotebookPersistentHeader(
                                notebook: notebookEntity as NotebookEntity,
                                totalNotes: notes.length,
                                totalFavorites: totalFavorites,
                                expandedHeight: 230.h,
                              ),
                            );
                          }
                          return SliverToBoxAdapter(
                            child: Container(
                              height: 230.h,
                            ),
                          );
                        },
                      ),
                      BlocConsumer<NoteBloc, NoteState>(
                        listener: (context, state) {
                          if (state is NoteCreated) {
                            kSnackBar(
                              context: context,
                              type: AlertType.success,
                              message: 'Note created Successfully',
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is NotesListLoading) {
                            return SliverToBoxAdapter(
                              child: SizedBox(
                                height: ScreenUtil.defaultSize.height * 0.6,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                          return SliverToBoxAdapter(
                            child: notes.isEmpty
                                ? _buildEmptyNotesUi()
                                : Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment(1, 10.h),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 20.w,
                                            right: 20.h,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            top: 0.h,
                                          ),
                                          child: _buildNotesGrid(),
                                        ),
                                      ),
                                    ],
                                  ),
                          );
                        },
                      )
                    ],
                  );
                },
              ),
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

  _buildEmptyNotesUi() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/empty-notes.json',
              fit: BoxFit.contain,
              height: 180.h,
            ),
            Text(
              'No notes found!',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildNotesGrid() {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state is AllSettingsFetchedState) {
          noteViewType = state.selectedView!;
          noteContentIsHidden = state.isNoteContentHidden!;
        }
        if (state is NoteViewSettingsChangedState) {
          noteViewType = state.selectedView;
        }
        if (state is NoteContentViewToggledState) {
          noteContentIsHidden = state.isNoteContentHidden;
        }

        return GridView.builder(
            shrinkWrap: true,
            primary: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: _getChildAspectRatio(),
              crossAxisCount: noteViewType == gridView ? 2 : 1,
              crossAxisSpacing: 15.w,
              mainAxisSpacing: 15.h,
            ),
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              var selectedNote = notes[index];
              return GestureDetector(
                onTap: () {
                  router.pushNamed(
                    AppRouters.notePage,
                    params: {RouterParams.noteId: selectedNote.id.toString()},
                  );
                },
                child: BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    if (state is NoteFavoriteToggledState) {
                      context.read<NoteBloc>().add(
                            GetAllNotesEvent(
                                notebookId: selectedNote.notebookId),
                          );
                    }
                    return NoteItem(
                      note: selectedNote,
                      viewType: noteViewType,
                      noteContentIsHidden: noteContentIsHidden,
                      onTapFavorite: () {
                        NoteEntity newNote = NoteEntity(
                          id: selectedNote.id,
                          title: selectedNote.title,
                          description: selectedNote.description,
                          isFavorite:
                              selectedNote.isFavorite == true ? false : true,
                          noteColor: selectedNote.noteColor,
                          createdAt: selectedNote.createdAt,
                          notebookId: selectedNote.notebookId,
                          editedAt: selectedNote.editedAt,
                          isLocked: selectedNote.isLocked,
                        );

                        context.read<NoteBloc>().add(
                              ToggleNoteFavoriteEvent(
                                note: newNote,
                              ),
                            );
                      },
                    );
                  },
                ),
              );
            });
      },
    );
  }

  double _getChildAspectRatio() {
    if (!noteContentIsHidden && (noteViewType == gridView)) {
      return 1;
    } else if (noteContentIsHidden && (noteViewType == gridView)) {
      return 2;
    } else if (!noteContentIsHidden && (noteViewType == listView)) {
      return 3.5;
    } else if (noteContentIsHidden && (noteViewType == listView)) {
      return 5;
    } else {
      return 1;
    }
  }
}
