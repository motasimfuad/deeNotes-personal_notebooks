import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/core/widgets/k_bottom_filter_menu.dart';
import 'package:notebooks/core/widgets/k_dialog.dart';
import 'package:notebooks/core/widgets/k_icon_button.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

import '../../../../core/constants/colors.dart';
import 'notebook_options_modal.dart';

class NotebookPersistentHeader extends SliverPersistentHeaderDelegate {
  NotebookEntity notebook;
  int totalNotes;
  final double expandedHeight;
  NotebookPersistentHeader({
    required this.notebook,
    required this.totalNotes,
    required this.expandedHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Image.asset(
          // ignore: unnecessary_null_comparison
          (notebook.cover != null && notebook.cover != '')
              ? notebook.cover
              : 'assets/images/notebooks/no-image.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: expandedHeight,
        ),
        Positioned(
          top: 20.h, //MediaQuery.of(context).padding.top,
          // right: 25,
          left: 20.w,
          child: KIconButton(
            bgColor: Colors.grey.withOpacity(0.3),
            iconColor: Colors.white,
            onPressed: () {
              router.pop();
            },
          ),
        ),
        Positioned(
          top: 20.h, //MediaQuery.of(context).padding.top,
          // right: 25,
          right: 20.w,
          child: KIconButton(
            icon: Icons.info_outline_rounded,
            bgColor: Colors.grey.withOpacity(0.3),
            iconColor: Colors.white,
            onPressed: () {
              KDialog(
                context: context,
                title: 'Notebook Details',
                showFooter: false,
                isDismissible: true,
                hasBorder: false,
                xInset: 70.w,
                yesBtnPressed: () {},
                dialogType: DialogType.form,
                formContent: [
                  NotebookOptionsModal(
                    notebook: notebook,
                    totalNotes: totalNotes,
                  )
                ],
              );
            },
          ),
        ),
        Positioned(
          top: expandedHeight - 47.h - shrinkOffset,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 22.w,
                vertical: 5.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      notebook.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: KColors.primary,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //! hidden for skipping labels for now
                  AbsorbPointer(
                    absorbing: true,
                    child: Opacity(
                      opacity: 0,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20.r),
                              ),
                            ),
                            builder: (context) =>
                                KBottomFilterMenu(notebook: notebook),
                          );
                        },
                        child: const Icon(
                          Icons.filter_alt_rounded,
                          color: KColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
