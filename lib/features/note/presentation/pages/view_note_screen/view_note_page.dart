import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebooks/core/constants/constants.dart';

import 'package:notebooks/features/note/domain/entities/note_entity.dart';

import '../../../../../core/widgets/k_appbar.dart';
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
                ),
                Container(
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
                ),
                Expanded(
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
                              SizedBox(height: 15.h),
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
                ),
              ],
            );
          },
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
                    icon: const Icon(
                      Icons.delete_forever_rounded,
                      color: KColors.primary,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: 'Add to favorite',
                    onPressed: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   AppRouter.editNote,
                      //   arguments: note,
                      // );
                    },
                    icon: const Icon(
                      Icons.favorite_outline_rounded,
                      color: KColors.primary,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Copy Note',
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: note?.description));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(milliseconds: 700),
                          backgroundColor: KColors.primary,
                          content: Text('Note copied to clipboard!'),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.copy_rounded,
                      color: KColors.primary,
                    ),
                  ),
                  IconButton(
                    tooltip: 'View in full screen',
                    onPressed: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   AppRouter.viewNoteFullScreen,
                      //   arguments: note,
                      // );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(milliseconds: 2000),
                          backgroundColor: note?.noteColor.color,
                          content: const Text('Full Screen mode'),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.open_in_new_rounded,
                      color: KColors.primary,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Edit Note',
                    onPressed: () {
                      // Navigator.pushNamed(
                      //   context,
                      //   AppRouter.editNote,
                      //   arguments: note,
                      // );
                    },
                    icon: const Icon(
                      Icons.border_color_outlined,
                      color: KColors.primary,
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
