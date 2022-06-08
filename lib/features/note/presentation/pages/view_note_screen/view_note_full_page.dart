import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/widgets/k_appbar.dart';

import 'package:notebooks/features/note/domain/entities/note_entity.dart';

import '../../bloc/note_bloc.dart';

class ViewNoteFullScreen extends StatefulWidget {
  int noteId;
  ViewNoteFullScreen({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  State<ViewNoteFullScreen> createState() => _ViewNoteFullScreenState();
}

class _ViewNoteFullScreenState extends State<ViewNoteFullScreen> {
  bool isNightMode = false;
  NoteEntity? note;

  @override
  void initState() {
    context.read<NoteBloc>().add(FindNoteEvent(id: widget.noteId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is NoteLoaded) {
            note = state.note;
          }
          return SafeArea(
            child: Container(
              color: isNightMode
                  ? Colors.black
                  : note?.noteColor.color.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  KAppbar(
                    label: note?.title ?? '',
                    iconBgColor: Colors.grey.withOpacity(0.1),
                    iconColor: note?.noteColor.color,
                    textColor: note?.noteColor.color,
                    context: context,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    actionIcon: isNightMode
                        ? Icons.wb_sunny_outlined
                        : Icons.nights_stay_outlined,
                    actionOnPressed: () {
                      setState(() {
                        isNightMode = !isNightMode;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(milliseconds: 700),
                            backgroundColor: note?.noteColor.color,
                            content: isNightMode
                                ? const Text('Reading mode on')
                                : const Text('Reading mode off'),
                          ),
                        );
                      });
                    },
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 22.w, right: 22.w, bottom: 20.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              note?.description ?? '',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                color: isNightMode
                                    ? Colors.grey.shade200
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
