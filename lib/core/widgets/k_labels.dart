import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/features/notebook/data/models/notebook.dart';
import 'package:notebooks/core/widgets/k_icon_button.dart';

class KLabels extends StatelessWidget {
  final Notebook notebook;
  final VoidCallback? onPressed;
  final bool showAddButton;
  const KLabels({
    Key? key,
    required this.notebook,
    this.onPressed,
    this.showAddButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: notebook.labels?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                var label = notebook.labels?[index]?.name;
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: FilterChip(
                    label: Text(label.toString()),
                    // ignore: unrelated_type_equality_checks
                    onSelected: (selected) {},

                    backgroundColor: Colors.grey.shade200,
                    selectedColor: Colors.grey,
                    labelStyle: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                );
              },
            ),
          ),

          // add new label
          showAddButton == true
              ? Container(
                  margin: EdgeInsets.only(left: 5.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: KIconButton(
                    onPressed: onPressed as VoidCallback,
                    bgColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                    iconColor: Colors.white,
                    icon: Icons.bookmark_add_outlined,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
