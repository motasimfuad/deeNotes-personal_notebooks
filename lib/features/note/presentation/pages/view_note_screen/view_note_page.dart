import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebooks/core/constants/constants.dart';
import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/core/widgets/k_dialog.dart';
import 'package:notebooks/core/widgets/k_snackbar.dart';

import 'package:notebooks/features/note/domain/entities/note_entity.dart';

import '../../../../../core/widgets/k_appbar.dart';
import '../../../../../core/widgets/k_icon_button.dart';
import '../../../../../core/widgets/k_snackbar_flat.dart';
import '../../bloc/note_bloc.dart';

class ViewNotePage extends StatefulWidget {
  // NotebookEntity notebook;
  // NoteEntity note;
  int noteId;
  ViewNotePage({
    Key? key,
    // required this.notebook,
    required this.noteId,
  }) : super(key: key);

  @override
  State<ViewNotePage> createState() => _ViewNotePageState();
}

class _ViewNotePageState extends State<ViewNotePage> {
  NoteEntity? note;

  @override
  void initState() {
    context.read<NoteBloc>().add(FindNoteEvent(id: widget.noteId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<NoteBloc, NoteState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is NoteLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NoteLoaded) {
              note = state.note;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildAppBarSection(context),
                _buildDateSection(),
                _buildNoteBodySection(),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 8.h,
          ),
          child: BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoading) {
                return const SizedBox();
              }
              // if (state is NoteLoaded)
              else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        KIconButton(
                          icon: Icons.delete_outline_rounded,
                          iconType: IconType.bottomBar,
                          tooltip: 'Delete note',
                          iconColor: note?.noteColor.color,
                          onPressed: () {
                            KDialog(
                              context: context,
                              title: 'Delete note?',
                              bodyText:
                                  'Are you sure you want to delete this note?',
                              yesBtnPressed: () {
                                context.read<NoteBloc>().add(
                                      DeleteNoteEvent(noteId: note?.id as int),
                                    );
                                Navigator.pop(context);
                                KSnackBar(
                                  context: context,
                                  type: AlertType.success,
                                  message: 'Note Deleted!',
                                );
                                router.pop();
                                context.read<NoteBloc>().add(
                                      GetAllNotesEvent(
                                          notebookId: note!.notebookId),
                                    );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        BlocConsumer<NoteBloc, NoteState>(
                          listener: (context, state) {
                            if (state is NoteFavoriteToggledState) {
                              String favStatus = state.note.isFavorite == true
                                  ? 'Note Added to Favorite'
                                  : 'Note Removed from Favorite';

                              KSnackbarFlat(
                                context: context,
                                message: favStatus,
                                bgColor: note!.noteColor.color,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is NoteFavoriteToggledState) {
                              note = state.note;

                              context.read<NoteBloc>().add(
                                    GetAllNotesEvent(
                                        notebookId: note!.notebookId),
                                  );
                            }
                            return KIconButton(
                              icon: note?.isFavorite == true
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline_rounded,
                              iconType: IconType.bottomBar,
                              tooltip: 'Add to favorite',
                              iconColor: note?.noteColor.color,
                              onPressed: () {
                                NoteEntity newNote = NoteEntity(
                                  id: note!.id,
                                  title: note!.title,
                                  description: note!.description,
                                  isFavorite:
                                      note!.isFavorite == true ? false : true,
                                  noteColor: note!.noteColor,
                                  createdAt: note!.createdAt,
                                  notebookId: note!.notebookId,
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
                        SizedBox(width: 12.w),
                        KIconButton(
                          icon: Icons.copy_rounded,
                          iconType: IconType.bottomBar,
                          tooltip: 'Copy Note',
                          iconColor: note?.noteColor.color,
                          onPressed: () {
                            String noteText =
                                '${note?.title}\n${note?.description}';
                            context.read<NoteBloc>().add(
                                  CopyNoteToClipboardEvent(
                                    noteText: noteText,
                                  ),
                                );
                            KSnackbarFlat(
                              context: context,
                              message: 'Note copied to clipboard',
                              bgColor: note?.noteColor.color,
                            );
                          },
                        ),
                        SizedBox(width: 12.w),
                        KIconButton(
                          icon: Icons.open_in_new_rounded,
                          iconType: IconType.bottomBar,
                          tooltip: 'View in full screen',
                          iconColor: note?.noteColor.color,
                          onPressed: () {
                            router.pushNamed(AppRouters.viewNoteFullScreenPage,
                                params: {
                                  RouterParams.noteId: note!.id.toString(),
                                });

                            KSnackbarFlat(
                              context: context,
                              message: 'Full Screen Mode',
                              bgColor: note?.noteColor.color,
                            );
                          },
                        ),
                        SizedBox(width: 12.w),
                        KIconButton(
                          icon: Icons.border_color_outlined,
                          iconType: IconType.bottomBar,
                          tooltip: 'Edit Note',
                          iconColor: note?.noteColor.color,
                          onPressed: () {
                            router.pushNamed(
                              AppRouters.editNotePage,
                              params: {
                                RouterParams.noteId: note!.id.toString(),
                              },
                            );
                          },
                        ),
                      ],
                    )
                  ],
                );
              }
              // else {
              //   return Container();
              // }
            },
          ),
        ),
      ),
    );
  }

  Expanded _buildNoteBodySection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: 22.w,
          right: 22.w,
          bottom: 20.h,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: note?.noteColor.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                left: 15.w,
                right: 15.w,
                top: 15.h,
                bottom: 15.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    note?.title ?? '',
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: note?.noteColor.color),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    note?.description ?? '',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildDateSection() {
    return Container(
      padding: EdgeInsets.only(
        left: 22.w,
        right: 22.w,
        bottom: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Created at: ${note?.createdAt.formatted}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
          Text(
            note?.description.split(' ').length.totalWords ?? '',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Column _buildAppBarSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        KAppbar(
          label: '',
          context: context,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: 20.w,
        //     vertical: 10.h,
        //   ),
        //   child: KLabels(
        //     showAddButton: false,
        //     notebook: notebook,
        //   ),
        // ),
      ],
    );
  }
}
