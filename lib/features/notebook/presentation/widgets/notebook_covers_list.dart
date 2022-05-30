import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/data_providers/notebook_covers_provider.dart';

class NotebookCoversList extends StatelessWidget {
  const NotebookCoversList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nbCoversProvider = NotebookCoversProvider();
    return Container(
      padding: EdgeInsets.only(
        left: 15.h,
        right: 15.w,
        top: 15.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: GridView.builder(
        padding: EdgeInsets.only(bottom: 15.h),
        shrinkWrap: true,
        primary: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.70,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
        ),
        itemCount: nbCoversProvider.notebookCovers.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.all(
                Radius.circular(6.r),
              ),
              image: DecorationImage(
                image: AssetImage(nbCoversProvider.notebookCovers[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
