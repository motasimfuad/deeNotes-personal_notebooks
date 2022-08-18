import 'package:flutter/material.dart';

import 'package:notebooks/core/constants/constants.dart';
import 'package:notebooks/features/note/domain/entities/note_entity.dart';

// ignore: must_be_immutable
class NoteItem extends StatelessWidget {
  NoteEntity note;
  Function()? onTapFavorite;
  NoteViewType? viewType;
  bool noteContentIsHidden;
  NoteItem({
    Key? key,
    required this.note,
    this.onTapFavorite,
    this.viewType,
    this.noteContentIsHidden = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: note.noteColor.color.withOpacity(0.1),
        border: Border.all(
          color: note.noteColor.color,
          width: 1,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12.r),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: viewType == NoteViewType.grid ? 2 : 1,
                    style: TextStyle(
                      color: note.noteColor.color,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: noteContentIsHidden ? 0 : 5.h),
                  noteContentIsHidden
                      ? const SizedBox()
                      : Expanded(
                          child: Text(
                            note.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: viewType == NoteViewType.grid ? 5 : 2,
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    note.editedAt == null
                        ? 'Created at: ${note.createdAt.onlyDate}'
                        : 'Last Edited: ${note.editedAt?.onlyDate}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.grey.shade900,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onTapFavorite,
                  child: Icon(
                    note.isFavorite == true
                        ? Icons.favorite_rounded
                        : Icons.favorite_outline_rounded,
                    color: note.noteColor.color,
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

