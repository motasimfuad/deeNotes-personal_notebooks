import 'package:flutter/material.dart';

import 'package:notebooks/core/constants/constants.dart';
import 'package:notebooks/core/widgets/k_icon_button.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_item.dart';

class NotebookOptionsModal extends StatelessWidget {
  final NotebookEntity notebook;
  final int totalNotes;
  final int totalFavorites;
  final Function() onDeletePressed;
  final Function() onEditPressed;
  const NotebookOptionsModal({
    Key? key,
    required this.notebook,
    required this.totalNotes,
    required this.totalFavorites,
    required this.onDeletePressed,
    required this.onEditPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // add label button
            Column(
              children: [
                NotebookItem(
                  notebook: notebook,
                  notebookHeight: 200.h,
                  isDetailsHidden: true,
                ),
                SizedBox(height: 10.h),
                Text(
                  notebook.name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: KColors.primary,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  totalNotes.totalNotes,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: KColors.primary,
                  ),
                ),
                Text(
                  '(${totalFavorites.totalFavs})',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    color: KColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                KIconButton(
                  icon: Icons.delete,
                  bgColor: KColors.danger,
                  iconColor: Colors.white,
                  onPressed: onDeletePressed,
                  // onPressed: () {
                  //   Navigator.pop(context);
                  //   kDialog(
                  //     context: context,
                  //     title: 'Delete Notebook?',
                  //     bodyText:
                  //         'Are you sure you want to delete this notebook?\nAll notes written in this notebook will also be removed. \n\nThis action cannot be undone!',
                  //     yesButtonText: 'YES, DELETE',
                  //     noButtonText: 'CANCEL',
                  //     yesBtnPressed: () {
                  //       context.read<NotebookBloc>().add(
                  //             DeleteNotebookEvent(
                  //               notebookId: notebook.id!,
                  //             ),
                  //           );
                  //       router.pop();
                  //       router.pushNamed(AppRouters.notebooksPage);

                  //       kSnackBar(
                  //         context: context,
                  //         type: AlertType.success,
                  //         message: 'Notebook deleted Successfully!',
                  //       );
                  //     },
                  //   );
                  // },
                ),
                SizedBox(width: 6.h),
                KIconButton(
                  icon: Icons.edit,
                  bgColor: KColors.primary,
                  iconColor: Colors.white,
                  onPressed: onEditPressed,
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
