import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/features/note/data/models/note.dart';

import 'package:notebooks/features/notebook/data/models/notebook.dart';
import 'package:notebooks/presentation/screens/create_note/create_note.dart';
import 'package:notebooks/presentation/screens/notebook_screen/widgets/note_item.dart';
import 'package:notebooks/presentation/screens/notebook_screen/widgets/notebook_persistent_header.dart';
import 'package:notebooks/presentation/screens/view_note_screen/view_note_screen.dart';
import 'package:notebooks/presentation/widgets/k_fab.dart';

class NoteBookScreen extends StatelessWidget {
  Notebook notebook;
  NoteBookScreen({
    Key? key,
    required this.notebook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: NotebookPersistentHeader(
              notebook: notebook,
              expandedHeight: 280.h,
            ),
          ),

          SliverToBoxAdapter(
            child: Stack(
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1,
                        crossAxisCount: 2,
                        crossAxisSpacing: 15.w,
                        mainAxisSpacing: 15.h,
                      ),
                      itemCount: notebook.notes?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var selectedNote = notebook.notes?[index] as Note;
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewNoteScreen(
                                  notebook: notebook, note: selectedNote),
                            ),
                          ),
                          child: NoteItem(note: selectedNote),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )

          // SliverGrid(
          //   delegate: SliverChildBuilderDelegate(
          //     (context, index) => Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: NoteItem(note: sampleNote),
          //     ),
          //     childCount: 20,
          //   ),
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     crossAxisSpacing: 10,
          //     mainAxisSpacing: 10,
          //   ),
          // ),

          // SliverToBoxAdapter(
          //   child: Container(
          //     color: Colors.white,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.stretch,
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             KAppbar(
          //               label: notebook.name,
          //               context: context,
          //               onPressed: () {
          //                 Navigator.pop(context);
          //               },
          //             ),
          //             Padding(
          //               padding: EdgeInsets.symmetric(
          //                 horizontal: 15.w,
          //                 vertical: 15.h,
          //               ),
          //               child: KLabels(
          //                 notebook: notebook,
          //                 onPressed: () => showModalBottomSheet(
          //                   context: context,
          //                   isScrollControlled: true,
          //                   clipBehavior: Clip.antiAlias,
          //                   shape: const RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.vertical(
          //                       top: Radius.circular(20),
          //                     ),
          //                   ),
          //                   builder: (context) =>
          //                       KAddLabelSheet(notebook: notebook),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(height: 5.h),
          //             Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(notebook.name),
          //                   Text(
          //                     // ignore: unrelated_type_equality_checks
          //                     '${notebook.notes?.length} notes',
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             SizedBox(height: 5.h),
          //           ],
          //         ),
          //         Expanded(
          //           child: Padding(
          //             padding: EdgeInsets.only(
          //               left: 20.w,
          //               right: 20.h,
          //               top: 10.h,
          //             ),
          //             child: GridView.builder(
          //               primary: false,
          //               shrinkWrap: true,
          //               padding: EdgeInsets.only(
          //                 bottom: 20.w,
          //               ),
          //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 2,
          //                 mainAxisSpacing: 18.h,
          //                 crossAxisSpacing: 18.w,
          //                 childAspectRatio: 1,
          //               ),
          //               itemCount: 20,
          //               itemBuilder: (BuildContext context, int index) {
          //                 // var note = notebook.notes?[index] as Note;
          //                 return GestureDetector(
          //                   // onTap: () => Navigator.push(
          //                   //   context,
          //                   //   MaterialPageRoute(
          //                   //     builder: (context) =>
          //                   //         ViewNoteScreen(notebook: notebook, note: note),
          //                   //   ),
          //                   // ),
          //                   child: NoteItem(
          //                     // note: notebook.notes?[index] as Note,
          //                     note: sampleNote,
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      floatingActionButton: KFab(
        label: 'New Note',
        icon: Icons.post_add,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) =>
                  CreateNote(notebook: notebook, note: sampleNote)),
            ),
          );
        },
      ),
    );
  }
}
