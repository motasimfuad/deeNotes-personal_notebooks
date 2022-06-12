import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/widgets/k_appbar.dart';

import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/core/widgets/k_select_color_sheet.dart';
import 'package:notebooks/core/widgets/k_snackbar.dart';
import 'package:notebooks/core/widgets/k_text_field.dart';
import 'package:notebooks/data/models/note_color.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';
import 'package:notebooks/features/note/presentation/bloc/note_bloc.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/widgets/k_bottom_sheet.dart';

class CreateNotePage extends StatefulWidget {
  final int notebookId;
  const CreateNotePage({
    Key? key,
    required this.notebookId,
  }) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String noteTitle = '';
  String noteDescription = '';
  NoteColor? noteColor;
  NoteColor? defaultNoteColor;

  @override
  void initState() {
    context.read<NoteBloc>().add(GetAllNoteColorsEvent());
    super.initState();
  }

  @override
  void dispose() {
    noteColor = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AllNoteColorsFetchedState) {
            defaultNoteColor = state.colors.first;
          }
          if (state is NoteColorSelectedState) {
            noteColor = state.color;
          }
          return SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    KAppbar(
                      label: 'Create Note',
                      context: context,
                      onPressed: () {
                        router.pop();
                      },
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 20.w,
                    //     vertical: 10.h,
                    //   ),
                    //   child: KLabels(
                    //     notebook: notebook,
                    //     onPressed: () => showModalBottomSheet(
                    //       context: context,
                    //       isScrollControlled: true,
                    //       clipBehavior: Clip.antiAlias,
                    //       shape: const RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.vertical(
                    //           top: Radius.circular(20),
                    //         ),
                    //       ),
                    //       builder: (context) => KAddLabelSheet(notebook: notebook),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22.w,
                        vertical: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              KTextField(
                                labelText: 'Title',
                                isBold: true,
                                controller: _titleController,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                ),
                                child: TextField(
                                  controller: _descriptionController,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 26,
                                  maxLines: 30,
                                  // expands: true,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.r),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    contentPadding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      top: 20.h,
                                      bottom: 0.h,
                                    ),
                                  ),
                                  scrollPadding: EdgeInsets.all(200.w),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: KFab(
        label: 'SAVE NOTE',
        onPressed: () async {
          NoteEntity noteEntity = NoteEntity(
            title: _titleController.text,
            description: _descriptionController.text,
            isFavorite: false,
            isLocked: false,
            noteColor: noteColor ?? defaultNoteColor!,
            notebookId: widget.notebookId,
            createdAt: DateTime.now(),
            editedAt: null,
          );

          if (noteEntity.title.isNotEmpty ||
              noteEntity.description.isNotEmpty) {
            BlocProvider.of<NoteBloc>(context).add(
              CreateNoteEvent(noteEntity),
            );
            router.pop();
          } else {
            kSnackBar(
              context: context,
              position: FlashPosition.top,
              type: AlertType.warning,
              message: 'Please fill all the fields',
            );
          }
        },
        icon: Icons.save_rounded,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  kBottomSheet(
                    context: context,
                    child: KSelectColorSheet(
                      noteColor: noteColor,
                    ),
                  );
                },
                icon: BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    return Icon(
                      Icons.color_lens,
                      color: noteColor?.color ?? defaultNoteColor?.color,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
