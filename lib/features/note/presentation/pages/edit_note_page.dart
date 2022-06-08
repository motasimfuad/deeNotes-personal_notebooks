import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/widgets/k_appbar.dart';

import 'package:notebooks/features/note/domain/entities/note_entity.dart';
import 'package:notebooks/features/notebook/data/models/notebook_model.dart';
import 'package:notebooks/core/widgets/k_add_label_sheet.dart';
import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/core/widgets/k_labels.dart';
import 'package:notebooks/core/widgets/k_select_color_sheet.dart';
import 'package:notebooks/core/widgets/k_text_field.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

import '../../../../core/constants/colors.dart';

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
  NoteEntity? note;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  void initState() {
    titleController.text = note?.title ?? '';
    descriptionController.text = note?.description ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NotebookEntity notebook = sampleNotebook;
    // Note note = sampleNote;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: true,
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 10.h,
                        ),
                        child: KLabels(
                          notebook: notebook,
                          onPressed: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            clipBehavior: Clip.antiAlias,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) =>
                                KAddLabelSheet(notebook: notebook),
                          ),
                        ),
                      ),
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
                            horizontal: 22.w, vertical: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                KTextField(
                                  controller: titleController,
                                  labelText: 'Title',
                                  isBold: true,
                                ),
                                Container(
                                  height: 490.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.r),
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
                                          Radius.circular(12.r),
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
                                    scrollPadding: EdgeInsets.all(160.w),
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
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: KFab(
        label: 'SAVE',
        onPressed: () {},
        icon: Icons.save_rounded,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: KColors.primary.withOpacity(0.1),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: KSelectColorSheet(),
                    ),
                    isDismissible: false,
                    isScrollControlled: false,
                    clipBehavior: Clip.antiAlias,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.color_lens,
                  color: KColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
