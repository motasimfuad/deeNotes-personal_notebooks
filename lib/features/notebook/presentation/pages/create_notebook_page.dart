import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_covers_list.dart';
import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/core/widgets/k_text_field.dart';

import '../../../../core/widgets/k_appbar.dart';
import '../../../../data/data_providers/notebook_covers_provider.dart';
import '../../domain/entities/notebook_entity.dart';
import '../bloc/notebook_bloc.dart';
import '../widgets/notebook_item.dart';

class CreateNotebookPage extends StatefulWidget {
  const CreateNotebookPage({Key? key}) : super(key: key);

  @override
  State<CreateNotebookPage> createState() => _CreateNotebookPageState();
}

class _CreateNotebookPageState extends State<CreateNotebookPage> {
  final TextEditingController _nameController = TextEditingController();
  String notebookName = '';
  NotebookCover? selectedCover;

  @override
  Widget build(BuildContext context) {
    double notebookHeight = MediaQuery.of(context).size.height * 0.30;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: const Color(0xFFF6F8FF),
      body: BlocConsumer<NotebookBloc, NotebookState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SafeArea(
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
                  child: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        children: [
                          FractionalTranslation(
                            translation: const Offset(0, 0),
                            child: SizedBox(
                              width: notebookHeight * 0.70,
                              height: notebookHeight,
                              child: SizedBox(
                                // height: 1,
                                // width: 1,
                                child: BlocBuilder<NotebookBloc, NotebookState>(
                                  builder: (context, state) {
                                    if (state
                                        is ViewNotebookOnCreatePageState) {
                                      // notebookName =
                                      //     state.notebookName.toString();
                                      selectedCover = state.cover;

                                      var newNotebook = NotebookEntity(
                                        name: notebookName,
                                        cover: selectedCover?.url ??
                                            state.cover.url,
                                        isLocked: false,
                                      );
                                      return NotebookItem(
                                        notebook: newNotebook,
                                      );
                                    } else {
                                      return NotebookItem(
                                        notebook: NotebookEntity(
                                          name: notebookName,
                                          cover: selectedCover?.url ?? '',
                                          isLocked: false,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40.h),
                          KTextField(
                            labelText: 'Notebook name',
                            hasBorder: true,
                            controller: _nameController,
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                notebookName = value;
                                // BlocProvider.of<NotebookBloc>(context).add(
                                //   ViewNotebookOnCreatePageEvent(
                                //     notebookName: notebookName,
                                //     cover: selectedCover == null
                                //         ? null
                                //         : selectedCover as NotebookCover,
                                //   ),
                                // );
                              });
                            },
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              SizedBox(width: 10.w),
                              Text(
                                'Notebook cover',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            height: 260.h,
                            child: NotebookCoversList(
                              selectedCover: (cover) {
                                setState(() {
                                  selectedCover = cover;
                                  print(cover);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: KFab(
        label: 'Create',
        icon: Icons.add_to_photos,
        onPressed: () {
          print(
              'notebookName: $notebookName, selectedCover: ${selectedCover?.url}');
        },
      ),
    );
  }
}
