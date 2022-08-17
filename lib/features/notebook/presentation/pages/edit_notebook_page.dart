import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/core/widgets/k_text_field.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_covers_list.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/k_appbar.dart';
import '../../../../data/data_providers/notebook_covers_provider.dart';
import '../../domain/entities/notebook_entity.dart';
import '../bloc/notebook_bloc.dart';
import '../widgets/notebook_item.dart';

class EditNotebookPage extends StatefulWidget {
  final int notebookId;
  const EditNotebookPage({
    Key? key,
    required this.notebookId,
  }) : super(key: key);

  @override
  State<EditNotebookPage> createState() => _EditNotebookPageState();
}

class _EditNotebookPageState extends State<EditNotebookPage> {
  final TextEditingController _nameController = TextEditingController();
  NotebookCover? selectedCover;
  NotebookEntity? selectedNotebookEntity;

  @override
  void initState() {
    context.read<NotebookBloc>().add(FindNotebookEvent(widget.notebookId));
    super.initState();
  }

  @override
  void dispose() {
    _nameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double notebookHeight = MediaQuery.of(context).size.height * 0.30;

    return WillPopScope(
      onWillPop: () async {
        context.read<NotebookBloc>().add(FindNotebookEvent(widget.notebookId));
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: const Color(0xFFF6F8FF),
        body: BlocConsumer<NotebookBloc, NotebookState>(
          listener: (context, state) {
            if (state is NotebookLoaded) {
              _nameController.text = state.notebook.name;
            }
          },
          builder: (context, state) {
            if (state is NotebookLoaded) {
              selectedNotebookEntity = state.notebook;
            }
            return SafeArea(
              child: Column(
                children: [
                  KAppbar(
                    label: 'Edit Notebook',
                    context: context,
                    iconBgColor: KColors.primary,
                    iconColor: Colors.white,
                    textColor: KColors.primary,
                    onPressed: () {
                      context
                          .read<NotebookBloc>()
                          .add(FindNotebookEvent(widget.notebookId));
                      router.pop();
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
                                  child:
                                      BlocBuilder<NotebookBloc, NotebookState>(
                                    builder: (context, state) {
                                      if (state is ViewNotebookCoverState) {
                                        selectedCover = state.cover;

                                        selectedNotebookEntity?.cover =
                                            selectedCover?.url ??
                                                state.cover.url;

                                        return NotebookItem(
                                          notebook: selectedNotebookEntity,
                                          isTotalNotesHidden: true,
                                        );
                                      } else {
                                        return NotebookItem(
                                          notebook: selectedNotebookEntity,
                                          isTotalNotesHidden: true,
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
                                  selectedNotebookEntity?.name = value;
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
                              child: BlocBuilder<NotebookBloc, NotebookState>(
                                builder: (context, state) {
                                  return const NotebookCoversList();
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
          label: 'Edit',
          icon: Icons.add_to_photos,
          onPressed: () {
            if (selectedNotebookEntity != null &&
                selectedNotebookEntity!.name.trim().isNotEmpty) {
              BlocProvider.of<NotebookBloc>(context).add(
                UpdateNotebookEvent(selectedNotebookEntity!),
              );
              context
                  .read<NotebookBloc>()
                  .add(FindNotebookEvent(widget.notebookId));
              router.pop();
            }
          },
        ),
      ),
    );
  }
}
