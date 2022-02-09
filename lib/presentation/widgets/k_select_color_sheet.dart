import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/data/models/note_color.dart';

import 'package:notebooks/presentation/widgets/k_appbar.dart';

class KSelectColorSheet extends StatefulWidget {
  const KSelectColorSheet({
    Key? key,
  }) : super(key: key);

  @override
  State<KSelectColorSheet> createState() => _KSelectColorSheetState();
}

class _KSelectColorSheetState extends State<KSelectColorSheet> {
  int isSelected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 200.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            KAppbar(
              label: 'Select Color',
              context: context,
              onPressed: () {
                Navigator.pop(context);
              },
              actionIcon: Icons.check_rounded,
              actionOnPressed: () {},
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 22.w, right: 22.w, top: 5.h),
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: 20.h),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 15.w,
                    mainAxisSpacing: 15.h,
                    childAspectRatio: 1,
                  ),
                  itemCount: noteColors.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          isSelected = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: noteColors[index].color,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.r),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
