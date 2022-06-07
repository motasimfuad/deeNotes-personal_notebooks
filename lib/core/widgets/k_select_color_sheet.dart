import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/core/widgets/k_appbar.dart';
import 'package:notebooks/data/models/note_color.dart';
import 'package:notebooks/features/note/presentation/bloc/note_bloc.dart';

import '../../data/data_providers/note_colors_provider.dart';

class KSelectColorSheet extends StatefulWidget {
  NoteColor? noteColor;
  KSelectColorSheet({
    Key? key,
    this.noteColor,
  }) : super(key: key);

  @override
  State<KSelectColorSheet> createState() => _KSelectColorSheetState();
}

class _KSelectColorSheetState extends State<KSelectColorSheet> {
  int isSelected = 0;
  NoteColor? selectedNoteColor;
  var noteColorsProvider = NoteColorsProvider();

  getNoteColor() {
    if (widget.noteColor != null) {
      // noteColorsProvider.noteColors.map((e) => e.color)
      selectedNoteColor = widget.noteColor;
      isSelected = noteColorsProvider.noteColors.indexOf(widget.noteColor!);
      // return widget.noteColor;
    } else if (selectedNoteColor != null) {
      isSelected = noteColorsProvider.noteColors.indexOf(selectedNoteColor!);
    } else {
      selectedNoteColor = noteColorsProvider.noteColors.first;
      isSelected = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    getNoteColor();
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 5.h),
          KAppbar(
            label: 'Select Color',
            context: context,
            onPressed: () {
              Navigator.pop(context);
            },
            actionIcon: Icons.check_rounded,
            actionOnPressed: () {
              BlocProvider.of<NoteBloc>(context).add(
                SelectNoteColorEvent(
                  color: noteColorsProvider.noteColors[isSelected],
                ),
              );

              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: 22.w,
                right: 22.w,
                top: 5.h,
              ),
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 20.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                  childAspectRatio: 1,
                ),
                itemCount: noteColorsProvider.noteColors.length,
                itemBuilder: (BuildContext context, int index) {
                  var noteColor = noteColorsProvider.noteColors[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // isSelected = index;
                        print(index);
                        selectedNoteColor = noteColor;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: noteColor.color,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                      ),
                      child: isSelected != index
                          ? const SizedBox.shrink()
                          : Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                              size: 30.h,
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
