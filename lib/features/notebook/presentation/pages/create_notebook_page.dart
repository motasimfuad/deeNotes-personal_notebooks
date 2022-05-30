import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_covers_list.dart';
import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/core/widgets/k_text_field.dart';

import '../../../../core/widgets/k_appbar.dart';
import '../widgets/notebook_item.dart';

class CreateNotebookPage extends StatefulWidget {
  const CreateNotebookPage({Key? key}) : super(key: key);

  @override
  State<CreateNotebookPage> createState() => _CreateNotebookPageState();
}

class _CreateNotebookPageState extends State<CreateNotebookPage> {
  @override
  Widget build(BuildContext context) {
    double notebookHeight = MediaQuery.of(context).size.height * 0.35;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      extendBody: true,
      // backgroundColor: Colors.white,
      backgroundColor: const Color(0xFFF6F8FF),
      body: SafeArea(
        child: Column(
          children: [
            KAppbar(
              label: 'Create Notebook',
              context: context,
              iconBgColor: Theme.of(context).primaryColor,
              iconColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.vertical,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      FractionalTranslation(
                        translation: const Offset(0, 0),
                        child: SizedBox(
                          width: notebookHeight * 0.70,
                          height: notebookHeight,
                          child: SizedBox(
                            height: 1,
                            width: 1,
                            child: NotebookItem(),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      const KTextField(
                        labelText: 'Notebook name',
                        hasBorder: true,
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10.w),
                          Text(
                            'Choose cover',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      SizedBox(
                        height: 260.h,
                        child: const NotebookCoversList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: KFab(
        label: 'Create',
        icon: Icons.add_to_photos,
        onPressed: () {},
      ),
    );
  }
}
