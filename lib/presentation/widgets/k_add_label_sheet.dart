import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/data/models/notebook.dart';
import 'package:notebooks/presentation/widgets/k_appbar.dart';
import 'package:notebooks/presentation/widgets/k_button.dart';
import 'package:notebooks/presentation/widgets/k_text_field.dart';

class KAddLabelSheet extends StatelessWidget {
  Notebook notebook;
  KAddLabelSheet({
    Key? key,
    required this.notebook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SizedBox(
        height: 240.h,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            KAppbar(
              label: 'Add label',
              context: context,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          KTextField(
                            labelText: 'Label',
                            hasBorder: true,
                          ),
                        ],
                      ),
                      KPrimaryButton(text: 'Add label', onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
