import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/features/note/data/models/note.dart';
import 'package:notebooks/features/note/presentation/pages/view_note_screen/view_note_screen.dart';

import 'package:notebooks/features/notebook/data/models/notebook.dart';
import 'package:notebooks/features/note/presentation/widgets/note_item.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_persistent_header.dart';
import 'package:notebooks/features/note/presentation/pages/create_note_page.dart';

import 'package:notebooks/core/widgets/k_fab.dart';

class NoteBookPage extends StatelessWidget {
  Notebook notebook;
  NoteBookPage({
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
                  CreateNotePage(notebook: notebook, note: sampleNote)),
            ),
          );
        },
      ),
    );
  }
}
