import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/data/models/note.dart';

class NoteItem extends StatelessWidget {
  Note note;
  NoteItem({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: note.color.withOpacity(0.1),
        border: Border.all(
          color: note.color,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 10.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: note.color,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  note.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Created at: 5.2.2022',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite_outline,
                    color: note.color,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// UnconstrainedBox(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(10)),
//                           color: note.color,
//                         ),
//                         margin: EdgeInsets.only(right: 5.w),
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 7.w, vertical: 2.5.h),
//                         child:  Text(
//                           '${note.labels?[index].name.toString()}',
//                           style: TextStyle(
//                             fontSize: 8,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),

