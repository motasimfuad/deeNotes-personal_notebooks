import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notebooks/core/constants/constants.dart';

import 'package:notebooks/features/note/domain/entities/note_entity.dart';

import '../../../../../core/widgets/k_appbar.dart';
import '../../../../../core/widgets/k_icon_button.dart';
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
                ),
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
              if (state is NoteLoaded) {
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
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        KIconButton(
                          icon: Icons.favorite_outline_rounded,
                          iconType: IconType.bottomBar,
                          tooltip: 'Add to favorite',
                          iconColor: note?.noteColor.color,
                          onPressed: () {},
                        ),
                        SizedBox(width: 12.w),
                        KIconButton(
                          icon: Icons.copy_rounded,
                          iconType: IconType.bottomBar,
                          tooltip: 'Copy Note',
                          iconColor: note?.noteColor.color,
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: note?.description));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 700),
                                backgroundColor:
                                    note?.noteColor.color ?? KColors.primary,
                                content:
                                    const Text('Note copied to clipboard!'),
                              ),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 2000),
                                backgroundColor: note?.noteColor.color,
                                content: const Text('Full Screen mode'),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: 12.w),
                        KIconButton(
                          icon: Icons.border_color_outlined,
                          iconType: IconType.bottomBar,
                          tooltip: 'Edit Note',
                          iconColor: note?.noteColor.color,
                          onPressed: () {},
                        ),
                      ],
                    )
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
