import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:notebooks/features/note/data/models/note_model.dart';
import 'package:notebooks/features/notebook/data/models/notebook_model.dart';
import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/core/widgets/k_labels.dart';

import '../../../../../core/widgets/k_appbar.dart';

class ViewNoteScreen extends StatelessWidget {
  NotebookModel notebook;
  NoteModel note;
  ViewNoteScreen({
    Key? key,
    required this.notebook,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                KAppbar(
                  label: '',
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
                    showAddButton: false,
                    notebook: notebook,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 10.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: note.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 595.h,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15.w,
                          right: 15.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 15.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Created',
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
                                  totalWords(
                                      note.description.split(' ').length),
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
                            SizedBox(height: 15.h),
                            Text(
                              note.title,
                              style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  color: note.color),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              note.description,
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    tooltip: 'Delete note',
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: 'Add to favorite',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.editNote,
                        arguments: note,
                      );
                    },
                    icon: Icon(
                      Icons.favorite_outline_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Copy Note',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: note.description));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 700),
                          backgroundColor: Theme.of(context).primaryColor,
                          content: const Text('Note copied to clipboard!'),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.copy_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    tooltip: 'View in full screen',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.viewNoteFullScreen,
                        arguments: note,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 2000),
                          backgroundColor: note.color,
                          content: const Text('Fullscreen mode'),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.open_in_new_rounded,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit Note',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouter.editNote,
                        arguments: note,
                      );
                    },
                    icon: Icon(
                      Icons.border_color_outlined,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

String totalWords(int quantity) {
  return Intl.plural(
    quantity,
    zero: '0 words',
    one: '$quantity word',
    other: '$quantity words',
    name: "word",
    args: [quantity],
    examples: const {'quantity': 4},
    desc: "Total number of words in the note",
  );
}
