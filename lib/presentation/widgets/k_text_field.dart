import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool isPassword;
  final bool isDisabled;
  final bool isRequired;
  final bool isBold;
  final bool hasBorder;
  final bool hasBottomMargin;
  final bool smallPadding;
  final Function? onChanged;

  const KTextField({
    Key? key,
    this.controller,
    required this.labelText,
    this.isPassword = false,
    this.isDisabled = false,
    this.isRequired = false,
    this.isBold = false,
    this.hasBorder = false,
    this.hasBottomMargin = true,
    this.smallPadding = false,
    this.onChanged,
  }) : super(key: key);

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: widget.hasBottomMargin ? 15.h : 0.h,
      ),
      child: TextField(
        onChanged: (value) {
          widget.onChanged;
        },
        controller: widget.controller,
        textInputAction: TextInputAction.next,
        obscureText: widget.isPassword && isVisible,
        style: widget.isBold
            ? TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
              )
            : TextStyle(
                color: widget.isDisabled == true
                    ? Colors.grey
                    : Colors.grey.shade900,
              ),
        decoration: widget.hasBorder == false
            ? InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(widget.smallPadding ? 10.r : 12.r),
                  ),
                ),
                hintText: widget.labelText,
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: widget.smallPadding ? 8.w : 20.h,
                ),
              )
            : InputDecoration(
                hintText: widget.labelText,
                enabled: widget.isDisabled == true ? false : true,
                fillColor: widget.isDisabled == true
                    ? Colors.grey.shade200
                    : Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius:
                      BorderRadius.circular(widget.smallPadding ? 9.r : 12.r),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                  borderRadius:
                      BorderRadius.circular(widget.smallPadding ? 9.r : 12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2.w,
                  ),
                  borderRadius:
                      BorderRadius.circular(widget.smallPadding ? 9.r : 12.r),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        icon: Icon(
                          isVisible ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey.shade400,
                        ),
                      )
                    : Container(
                        width: 0,
                      ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 15.w,
                  vertical: widget.smallPadding ? 8.w : 20.h,
                ),
              ),
      ),
    );
  }
}
