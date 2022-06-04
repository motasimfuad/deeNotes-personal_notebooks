import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/features/note/data/models/note_model.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';

import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_persistent_header.dart';
import 'package:notebooks/features/note/presentation/pages/create_note_page.dart';

import 'package:notebooks/core/widgets/k_fab.dart';

class NoteBookPage extends StatelessWidget {
  NotebookEntity notebook;
  NoteBookPage({
    Key? key,
    required this.notebook,
  }) : super(key: key);

  List<NoteEntity> notes = [];

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
                        // itemCount: notebook.notes?.length,
                        itemCount: notes.length,
                        itemBuilder: (BuildContext context, int index) {
                          // ignore: prefer_is_empty
                          // if (notebook.notes == null) {
                          return Container(
                            child: const Center(
                              child: Text(
                                'No notes',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                          // }
                          // var selectedNote = notebook.notes![index]!;
                          // return GestureDetector(
                          //   onTap: () => Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => ViewNoteScreen(
                          //           notebook: notebook, note: selectedNote),
                          //     ),
                          //   ),
                          //   child: NoteItem(note: selectedNote),
                          // );
                        }),
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
