import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/core/widgets/k_bottom_filter_menu.dart';
import 'package:notebooks/core/widgets/k_dialog.dart';
import 'package:notebooks/core/widgets/k_icon_button.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/k_snackbar.dart';
import '../bloc/notebook_bloc.dart';
import 'notebook_options_modal.dart';

class NotebookPersistentHeader extends SliverPersistentHeaderDelegate {
  NotebookEntity notebook;
  int totalNotes;
  int totalFavorites;
  final double expandedHeight;
  NotebookPersistentHeader({
    required this.notebook,
    required this.totalNotes,
    required this.totalFavorites,
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
              kDialog(
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
                    totalFavorites: totalFavorites,
                    onDeletePressed: () {
                      Navigator.pop(context);
                      kDialog(
                        context: context,
                        title: 'Delete Notebook?',
                        bodyText:
                            'Are you sure you want to delete this notebook?\nAll notes written in this notebook will also be removed. \n\nThis action cannot be undone!',
                        yesButtonText: 'YES, DELETE',
                        noButtonText: 'CANCEL',
                        yesBtnPressed: () {
                          context.read<NotebookBloc>().add(
                                DeleteNotebookEvent(
                                  notebookId: notebook.id!,
                                ),
                              );
                          router.pop();
                          router.pushNamed(AppRouters.notebooksPage);

                          kSnackBar(
                            context: context,
                            type: AlertType.success,
                            message: 'Notebook deleted Successfully!',
                          );
                        },
                      );
                    },
                    onEditPressed: () {
                      Navigator.pop(context);
                      router.pushNamed(
                        AppRouters.editNotebookPage,
                        params: {
                          'notebookId': notebook.id.toString(),
                        },
                      );
                    },
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
                topLeft: Radius.circular(25.r),
                topRight: Radius.circular(25.r),
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
