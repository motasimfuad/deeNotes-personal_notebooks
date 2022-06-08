import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notebooks/core/constants/constants.dart';

import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

class NotebookItem extends StatelessWidget {
  NotebookEntity? notebook;
  int? totalNotes;
  double? notebookHeight;
  bool? isDetailsHidden;
  NotebookItem({
    Key? key,
    this.notebook,
    this.totalNotes,
    this.notebookHeight,
    this.isDetailsHidden = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    notebookHeight =
        notebookHeight ?? MediaQuery.of(context).size.height * 0.30;

    return FractionalTranslation(
      translation: const Offset(0, 0),
      child: Container(
        width: notebookHeight! * 0.70,
        height: notebookHeight,
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3.r),
          color: const Color(0xFFF8FAFB),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(3.w, 3.h),
              blurRadius: 3.5.r,
              blurStyle: BlurStyle.normal,
              spreadRadius: 1,
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(30.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(30.r),
          ),
          image: (notebook?.cover != null && notebook?.cover != '')
              ? DecorationImage(
                  image: AssetImage(notebook!.cover),
                  fit: BoxFit.cover,
                )
              : const DecorationImage(
                  image: AssetImage('assets/images/notebooks/no-image.png'),
                  fit: BoxFit.contain,
                ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(29.r),
            bottomLeft: Radius.circular(12.r),
            bottomRight: Radius.circular(29.r),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.1),
                  Colors.transparent
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                stops: const [
                  0.1,
                  0.3,
                  0.5,
                  0.7,
                  1,
                ],
              ),
              // borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 15.h,
              ),
              child: isDetailsHidden == true
                  ? const SizedBox()
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          notebook?.name ?? 'Notebook Name',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          // '${notebook?.notes?.length.toString()} notes',
                          totalNotes.totalNotes(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

String totalNotes(int quantity) {
  return Intl.plural(
    quantity,
    zero: '0 notes',
    one: '$quantity note',
    other: '$quantity notes',
    name: "note",
    args: [quantity],
    examples: const {'quantity': 4},
    desc: "Total number of notes in the notebook",
  );
}
