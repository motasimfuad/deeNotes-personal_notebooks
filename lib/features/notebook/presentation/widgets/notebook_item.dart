import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

class NotebookItem extends StatelessWidget {
  NotebookEntity? notebook;
  NotebookItem({
    Key? key,
    this.notebook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        image: notebook?.cover != null
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  notebook?.name ?? 'Notebook Name',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  // '${notebook?.notes?.length.toString()} notes',
                  notebook?.notes?.length != null
                      ? totalNotes(notebook?.notes?.length as int)
                      : 'No notes yet!',
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
