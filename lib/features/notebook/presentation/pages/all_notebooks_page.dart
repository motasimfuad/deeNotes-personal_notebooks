import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/core/widgets/k_fab.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_item.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/k_icon_button.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../domain/entities/notebook_entity.dart';
import '../bloc/notebook_bloc.dart';

class AllNotebooksPage extends StatefulWidget {
  const AllNotebooksPage({Key? key}) : super(key: key);

  @override
  State<AllNotebooksPage> createState() => _AllNotebooksPageState();
}

class _AllNotebooksPageState extends State<AllNotebooksPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<NotebookEntity> notebooks = [];

  @override
  void initState() {
    BlocProvider.of<NotebookBloc>(context).add(const GetAllNotebooksEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: notebooks.isEmpty ? null : const Color(0xFFF6F8FF),
      endDrawer: _buildDrawer(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text(Strings.appTitle),
              elevation: 0,
              centerTitle: true,
              backgroundColor: Colors.transparent,
              titleTextStyle: TextStyle(
                color: KColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 23.sp,
              ),
              collapsedHeight: 60.h,
              actions: [
                KIconButton(
                  bgColor: Colors.transparent,
                  icon: Icons.menu_rounded,
                  iconColor: KColors.primary.shade200,
                  onPressed: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                ),
                SizedBox(width: 15.w),
              ],
            ),
            BlocConsumer<NotebookBloc, NotebookState>(
              listener: (context, state) {},
              builder: (context, state) {
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
                              child: SizedBox(
                                height: 180.h,
                                child: Lottie.asset(
                                  'assets/animations/empty-notebooks.json',
                                ),
                              ),
                            ),
                            Text(
                              'Create your first notebook!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
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
                              pathParameters: {
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: KFab(
        label: 'New Notebook',
        icon: Icons.add_to_photos,
        onPressed: () async {
          router.pushNamed(AppRouters.createNotebookPage);
        },
      ),
    );
  }

  _buildDrawer() {
    return SafeArea(
      child: Container(
        color: Colors.grey.shade50,
        width: 220.w,
        padding: EdgeInsets.only(
          top: 20.w,
          left: 0.w,
          right: 0.w,
          bottom: 10.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 40.h,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/app/deeNotes-playstore-logo.png',
                    fit: BoxFit.cover,
                    width: 60.w,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    Strings.appTitle,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: KColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  minLeadingWidth: 0,
                  leading: Icon(
                    Icons.settings,
                    size: 24.w,
                    color: Colors.grey.shade600,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    BlocProvider.of<SettingsBloc>(context)
                        .add(UpdateSettingsEvent());
                    router.pushNamed(AppRouters.settingsPage);
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10.h,
                    left: 15.w,
                    right: 10.w,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Drag right or tap to close',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 26.w,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
