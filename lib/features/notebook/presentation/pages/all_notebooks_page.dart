import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_item.dart';
import 'package:notebooks/core/widgets/k_fab.dart';

import '../../domain/entities/notebook_entity.dart';
import '../bloc/notebook_bloc.dart';

class AllNotebooksPage extends StatelessWidget {
  AllNotebooksPage({Key? key}) : super(key: key);

  List<NotebookEntity> notebooks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              'Notebooks',
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(),
            leadingWidth: 10.w,
            titleTextStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          // SliverGrid.count(crossAxisCount: 2)

          BlocConsumer<NotebookBloc, NotebookState>(
            listener: (context, state) {
              // if (state is NotebookInitial) {
              //   context.read<NotebookBloc>().add(const GetAllNotebooksEvent());
              // }
            },
            builder: (context, state) {
              if (state is NotebookInitial) {
                context.read<NotebookBloc>().add(const GetAllNotebooksEvent());
              }
              if (state is NotebookListLoading) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is NotebookListLoaded) {
                notebooks = state.notebooks;
              }
              if (notebooks.length < 11) {
                return SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(
                      child: Text(
                        '''No notebooks found!
          You can create a new notebook by tapping the button below''',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                        left: 20.w, right: 20.w, bottom: 70.h, top: 5.h),
                    itemCount: notebooks.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          // print(notebooks[index].notes?.length),
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => NoteBookPage(
                          //       // notebook: notebooks[index],
                          //       notebookId: notebooks[index].id as int,

                          //       // notebook: sampleNotebook,
                          //     ),
                          //   ),
                          // );
                          router.pushNamed(
                            notebookScreen,
                            params: {
                              'notebookId': notebooks[index].id.toString(),
                            },
                          );
                          // context.read<NotebookBloc>().add(
                          //     FindNotebookEvent(notebooks[index].id as int));
                        },
                        child: NotebookItem(notebook: notebooks[index]),
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
        alignment: Alignment(1, 0.87.h),
        child: KFab(
          label: 'New Notebook',
          icon: Icons.add_to_photos,
          onPressed: () async {
            // DataRepository.instance.createNotebook(NotebookModel(
            //   name: 'book name 2',
            //   cover: '',
            //   isLocked: false,
            // ));

            // DataRepository.instance.getAllNotebooks();
            // var notebook = await DataRepository.instance.findNotebook(13);
            // print('notebook: $notebook');
            // DataRepository.instance.closeDatabase();

            // Navigator.of(context).pushNamed('createNotebook');
          },
        ),
      ),
    );
  }
}
