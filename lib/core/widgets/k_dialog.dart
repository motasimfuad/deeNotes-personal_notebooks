import 'package:flutter/material.dart';

import '../constants/constants.dart';

enum DialogType { alert, form }

KDialog({
  required BuildContext context,
  String? title,
  String? yesButtonText,
  String? noButtonText,
  Color? yesButtonColor,
  Color? noButtonColor,
  String? bodyText,
  double? xInset,
  bool? showFooter = true,
  List<Widget>? formContent,
  DialogType? dialogType = DialogType.alert,
  bool? isDismissible,
  bool? hasBorder = true,
  required Function()? yesBtnPressed,
}) {
  // get body content
  Widget getWidget(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            bodyText ?? '',
          ),
        );
      case DialogType.form:
        return SingleChildScrollView(
          primary: false,
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: formContent ?? []
              ..add(
                SizedBox(
                  height: 0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
          ),
        );

      default:
        return Text(
          bodyText ?? 'Delete',
        );
    }
  }

  // yes button text
  String getYesButtonText(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return 'Yes';
      case DialogType.form:
        return 'Submit';
      default:
        return 'Yes';
    }
  }

  // no button text
  String getNoButtonText(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return 'No';
      case DialogType.form:
        return 'Cancel';
      default:
        return 'No';
    }
  }

  // Yes button color
  Color getYesButtonColor(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return KColors.danger;
      case DialogType.form:
        return KColors.primary;
      default:
        return KColors.danger;
    }
  }

  // No button color
  Color getNoButtonColor(dialogType) {
    switch (dialogType) {
      case DialogType.alert:
        return KColors.green;
      case DialogType.form:
        return Colors.grey.shade400;
      default:
        return KColors.green;
    }
  }

  // main dialog
  showDialog(
    context: context,
    barrierDismissible: isDismissible ?? false,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title ?? 'Please Confirm',
                maxLines: 1,
                style: TextStyle(
                  fontSize: 17.sp,
                  overflow: TextOverflow.ellipsis,
                  color: KColors.primary,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close_rounded,
                  color: KColors.primary,
                  size: 18.w,
                ),
              ),
            ],
          ),
          titlePadding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 15.h,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0.h,
          ),
          actionsPadding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 0.h,
          ),
          insetPadding: dialogType == DialogType.form
              ? EdgeInsets.symmetric(
                  horizontal: xInset ?? 40.w,
                  vertical: 30.h,
                )
              : EdgeInsets.symmetric(
                  horizontal: xInset ?? 40.w,
                  vertical: 24.h,
                ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.r),
            ),
          ),
          content: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 15.h,
              bottom: dialogType == DialogType.form ? 15.h : 15.h,
              right: 15.w,
              left: 15.w,
            ),
            decoration: BoxDecoration(
              border: hasBorder == true
                  ? Border(
                      top: BorderSide(
                        color: KColors.primary.shade300,
                        width: 0.3.w,
                      ),
                      bottom: BorderSide(
                        color: KColors.primary.shade300,
                        width: 0.3.w,
                      ),
                    )
                  : null,
            ),
            child: getWidget(dialogType),
          ),
          actions: showFooter == true
              ? <Widget>[
                  k_dialog_button(
                    buttonText: noButtonText ?? getNoButtonText(dialogType),
                    bgColor: noButtonColor ?? getNoButtonColor(dialogType),
                    fontSize: dialogType == DialogType.form ? 15.5.sp : 14.sp,
                  ),
                  k_dialog_button(
                    buttonText: yesButtonText ?? getYesButtonText(dialogType),
                    bgColor: yesButtonColor ?? getYesButtonColor(dialogType),
                    fontSize: dialogType == DialogType.form ? 15.5.sp : 14.sp,
                    onPressed: yesBtnPressed,
                  ),
                ]
              : null,
        ),
      );
    },
  );
}

class k_dialog_button extends StatelessWidget {
  String buttonText;
  Color bgColor;
  Function()? onPressed;
  double? fontSize;
  k_dialog_button({
    Key? key,
    required this.buttonText,
    required this.bgColor,
    this.onPressed,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () => Navigator.pop(context),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 11.w,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: bgColor,
      ),
    );
  }
}
