import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/widgets/k_appbar.dart';

import 'package:notebooks/features/note/data/models/note.dart';

class ViewNoteFullScreen extends StatefulWidget {
  Note note;
  ViewNoteFullScreen({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<ViewNoteFullScreen> createState() => _ViewNoteFullScreenState();
}

class _ViewNoteFullScreenState extends State<ViewNoteFullScreen> {
  bool isNightMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color:
              isNightMode ? Colors.black : widget.note.color.withOpacity(0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              KAppbar(
                label: widget.note.title,
                iconBgColor: Colors.grey.withOpacity(0.1),
                iconColor: widget.note.color,
                textColor: widget.note.color,
                context: context,
                onPressed: () {
                  Navigator.pop(context);
                },
                actionIcon: isNightMode
                    ? Icons.wb_sunny_outlined
                    : Icons.nights_stay_outlined,
                actionOnPressed: () {
                  setState(() {
                    isNightMode = !isNightMode;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 700),
                        backgroundColor: widget.note.color,
                        content: isNightMode
                            ? const Text('Reading mode on')
                            : const Text('Reading mode off'),
                      ),
                    );
                  });
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 22.w, right: 22.w, bottom: 20.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.note.description,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w400,
                            color: isNightMode
                                ? Colors.grey.shade200
                                : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
