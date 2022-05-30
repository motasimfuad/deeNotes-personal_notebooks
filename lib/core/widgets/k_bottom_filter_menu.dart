import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/widgets/k_appbar.dart';
import 'package:notebooks/core/widgets/k_text_field.dart';

import 'package:notebooks/core/widgets/k_icon_button.dart';
import 'package:notebooks/features/notebook/domain/entities/notebook_entity.dart';

class KBottomFilterMenu extends StatelessWidget {
  NotebookEntity notebook;
  KBottomFilterMenu({
    Key? key,
    required this.notebook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 480.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const SizedBox(height: 5),
            KAppbar(
              label: 'Choose Label',
              context: context,
              onPressed: () {
                Navigator.pop(context);
              },
              actionIcon: Icons.checklist_rtl_rounded,
              actionOnPressed: () {},
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 0.h,
                  bottom: 20.h,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index) {
                          var labelSelected = false;
                          return CheckboxListTile(
                            title: const Text('data'),
                            value: labelSelected,
                            onChanged: (newValue) {},
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // add label button
                    SizedBox(
                      height: 48.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: KTextField(
                              labelText: 'Add label',
                              hasBottomMargin: false,
                              smallPadding: true,
                              hasBorder: true,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          KIconButton(
                            onPressed: () {},
                            size: 46.5.h,
                            bgColor: Theme.of(context).primaryColor,
                            iconColor: Colors.white,
                            icon: Icons.post_add_rounded,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
