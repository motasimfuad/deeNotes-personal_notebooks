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

class CreateNotePage extends StatefulWidget {
  int notebookId;
  CreateNotePage({
    Key? key,
    required this.notebookId,
  }) : super(key: key);

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  String noteTitle = '';
  String noteDescription = '';
  NoteColor? noteColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {
          if (state is NoteColorSelectedState) {
            noteColor = state.color;

            KSnackBar(
              context: context,
              message: 'Note color changed to ${state.color.color.toString()}',
            );
          }
        },
        builder: (context, state) {
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const KTextField(
                                labelText: 'Title',
                                isBold: true,
                              ),
                              Container(
                                // height: 490.h,
                                // height:
                                //     MediaQuery.of(context).size.height * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12.r),
                                  ),
                                ),
                                child: TextField(
                                  keyboardType: TextInputType.multiline,
                                  minLines: 26,
                                  maxLines: 30,
                                  decoration: InputDecoration(
                                    hintText: 'Description',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.r),
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
                                  scrollPadding: EdgeInsets.all(150.w),
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
            title: 'headline6',
            description: 'description',
            isFavorite: false,
            noteColor: NoteColor(id: 1, color: Colors.blue),
            notebookId: widget.notebookId,
            createdAt: DateTime.now(),
          );

          print(noteEntity.toString());
          BlocProvider.of<NoteBloc>(context).add(
            CreateNoteEvent(noteEntity),
          );

          router.pop();
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
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                      height: 340.h,
                      child: KSelectColorSheet(
                        noteColor: noteColor,
                      ),
                    ),
                    isDismissible: false,
                    isScrollControlled: false,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                    ),
                  );
                },
                icon: BlocBuilder<NoteBloc, NoteState>(
                  builder: (context, state) {
                    return Icon(
                      Icons.color_lens,
                      color: noteColor?.color,
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
