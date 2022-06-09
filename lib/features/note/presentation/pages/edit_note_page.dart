import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/widgets/k_appbar.dart';
import 'package:notebooks/core/widgets/k_bottom_sheet.dart';

import 'package:notebooks/features/note/domain/entities/note_entity.dart';
import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/core/widgets/k_select_color_sheet.dart';
import 'package:notebooks/core/widgets/k_text_field.dart';
import 'package:notebooks/features/note/presentation/bloc/note_bloc.dart';

import '../../../../data/models/note_color.dart';

class EditNotePage extends StatefulWidget {
  int noteId;
  EditNotePage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  NoteEntity? note;
  NoteColor? noteColor;
  NoteColor? defaultNoteColor;

  @override
  void initState() {
    print('initState');
    context.read<NoteBloc>().add(FindNoteEvent(id: widget.noteId));

    titleController.text = note?.title ?? '';
    descriptionController.text = note?.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteLoaded) {
            note = state.note;

            titleController.text = note?.title ?? '';
            descriptionController.text = note?.description ?? '';
          }

          if (state is AllNoteColorsFetchedState) {
            defaultNoteColor = state.colors.first;
          }

          if (state is NoteColorSelectedState) {
            noteColor = state.color;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Column(
                  children: [
                    KAppbar(
                      label: 'Edit Note',
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
                    //       builder: (context) =>
                    //           KAddLabelSheet(notebook: notebook),
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
                      padding: EdgeInsets.only(
                        left: 22.w,
                        right: 22.w,
                        // vertical: 20.h,
                        bottom: 20.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              KTextField(
                                controller: titleController,
                                labelText: 'Title',
                                isBold: true,
                                fillColor:
                                    note?.noteColor.color.withOpacity(0.1),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  // color:
                                  //     note?.noteColor.color.withOpacity(0.1) ??
                                  //         Colors.grey.shade400,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.r),
                                  ),
                                ),
                                child: TextField(
                                  controller: descriptionController,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 26,
                                  maxLines: 30,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.r),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: note?.noteColor.color
                                            .withOpacity(0.1) ??
                                        Colors.grey.shade100,
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
        label: 'UPDATE',
        onPressed: () {},
        icon: Icons.save_rounded,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // showModalBottomSheet(
                  //   context: context,
                  //   builder: (context) => SizedBox(
                  //     child: KSelectColorSheet(
                  //       noteColor: noteColor,
                  //     ),
                  //   ),
                  //   isDismissible: false,
                  //   isScrollControlled: false,
                  //   clipBehavior: Clip.antiAlias,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.vertical(
                  //       top: Radius.circular(20.r),
                  //     ),
                  //   ),
                  // );
                  KBottomSheet(
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
                      color: note?.noteColor.color ?? defaultNoteColor?.color,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
