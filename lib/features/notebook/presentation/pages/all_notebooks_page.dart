import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_item.dart';
import 'package:notebooks/core/widgets/k_fab.dart';

import '../../../../core/constants/colors.dart';
import '../../domain/entities/notebook_entity.dart';
import '../bloc/notebook_bloc.dart';

class AllNotebooksPage extends StatefulWidget {
  const AllNotebooksPage({Key? key}) : super(key: key);

  @override
  State<AllNotebooksPage> createState() => _AllNotebooksPageState();
}

class _AllNotebooksPageState extends State<AllNotebooksPage> {
  List<NotebookEntity> notebooks = [];

  @override
  void initState() {
    BlocProvider.of<NotebookBloc>(context).add(const GetAllNotebooksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: notebooks.isEmpty ? null : const Color(0xFFF6F8FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Notebooks'),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            // leading: Container(),
            // leadingWidth: 10.w,
            titleTextStyle: TextStyle(
              color: KColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 23.sp,
            ),
          ),
          // SliverGrid.count(crossAxisCount: 2)

          BlocConsumer<NotebookBloc, NotebookState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is NotebookInitial) {
                // context.read<NotebookBloc>().add(const GetAllNotebooksEvent());
              }
              if (state is NotebookListLoading) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: ScreenUtil.defaultSize.height * 0.6,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
              if (state is NotebookListLoaded) {
                notebooks = state.notebooks;
              }
              if (notebooks.isEmpty) {
                return SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(80.w),
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          GestureDetector(
                            onTap: () {
                              router.pushNamed(AppRouters.createNotebookPage);
                            },
                            child: Lottie.asset(
                              'assets/animations/empty-notebooks.json',
                            ),
                          ),
                          Text(
                            'Create your first notebook by \ntapping the button!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: 70.h,
                      top: 5.h,
                    ),
                    itemCount: notebooks.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      var reversedList = notebooks.reversed.toList();
                      return GestureDetector(
                        onTap: () {
                          router.pushNamed(
                            AppRouters.notebookPage,
                            params: {
                              'notebookId': reversedList[index].id.toString(),
                            },
                          );
                        },
                        child: NotebookItem(
                          notebook: reversedList[index],
                          isTotalNotesHidden: true,
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Align(
        alignment: Alignment(1.w, 1.h),
        child: KFab(
          label: 'New Notebook',
          icon: Icons.add_to_photos,
          onPressed: () async {
            router.pushNamed(AppRouters.createNotebookPage);
          },
        ),
      ),
    );
  }
}
