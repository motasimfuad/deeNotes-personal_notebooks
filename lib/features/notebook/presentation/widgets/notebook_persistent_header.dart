import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/router/app_router.dart';

import 'package:notebooks/core/widgets/k_bottom_filter_menu.dart';
import 'package:notebooks/core/widgets/k_icon_button.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

import '../../../../core/constants/colors.dart';

class NotebookPersistentHeader extends SliverPersistentHeaderDelegate {
  final NotebookEntity notebook;
  final double expandedHeight;
  NotebookPersistentHeader({
    required this.notebook,
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
          top: 50.h, //MediaQuery.of(context).padding.top
          // right: 25,
          left: 25.w,
          child: KIconButton(
            bgColor: Colors.grey.withOpacity(0.5),
            iconColor: Colors.white,
            onPressed: () {
              router.pop();
            },
          ),
        ),
        Positioned(
          top: expandedHeight - 40.h - shrinkOffset,
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
                vertical: 15.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    notebook.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: KColors.primary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      debugPrint('filter');

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
