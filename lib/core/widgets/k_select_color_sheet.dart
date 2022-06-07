import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/core/widgets/k_appbar.dart';
import 'package:notebooks/data/models/note_color.dart';
import 'package:notebooks/features/note/presentation/bloc/note_bloc.dart';

import '../../data/data_providers/note_colors_provider.dart';

class KSelectColorSheet extends StatefulWidget {
  NoteColor? noteColor;
  Function(NoteColor)? onSelected;
  KSelectColorSheet({
    Key? key,
    this.noteColor,
    this.onSelected,
  }) : super(key: key);

  @override
  State<KSelectColorSheet> createState() => _KSelectColorSheetState();
}

class _KSelectColorSheetState extends State<KSelectColorSheet> {
  int isSelected = 0;
  NoteColor? selectedNoteColor;
  List<NoteColor> noteColors = [];

  var noteColorsProvider = NoteColorsProvider();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: BlocConsumer<NoteBloc, NoteState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is NoteColorsLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AllNoteColorsFetchedState) {
                    noteColors = state.colors;
                  }
                  if (state is NoteColorSelectedState) {
                    selectedNoteColor = state.color;
                    isSelected = noteColors
                        .indexWhere((element) => element.id == state.color.id);
                  }
                  if (state is! NoteColorSelectedState) {
                    selectedNoteColor = noteColors.first;
                    isSelected = 0;
                    widget.onSelected?.call(selectedNoteColor!);
                  }
                  return GridView.builder(
                    padding: EdgeInsets.only(bottom: 20.h),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                      childAspectRatio: 1,
                    ),
                    itemCount: noteColors.length,
                    itemBuilder: (BuildContext context, int index) {
                      var noteColor = noteColors[index];
                      return GestureDetector(
                        onTap: () {
                          BlocProvider.of<NoteBloc>(context).add(
                            SelectNoteColorEvent(
                              color: noteColor,
                            ),
                          );
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
