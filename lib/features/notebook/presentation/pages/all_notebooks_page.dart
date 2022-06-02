import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/features/notebook/data/models/notebook_model.dart';
import 'package:notebooks/features/notebook/presentation/widgets/notebook_item.dart';
import 'package:notebooks/core/widgets/k_fab.dart';

import 'notebook_page.dart';

class AllNotebooksPage extends StatelessWidget {
  const AllNotebooksPage({Key? key}) : super(key: key);

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

          SliverToBoxAdapter(
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.only(
                  left: 20.w, right: 20.w, bottom: 70.h, top: 5.h),
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.w,
                mainAxisSpacing: 20.h,
                childAspectRatio: 0.70,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoteBookPage(
                        notebook: sampleNotebook,
                      ),
                    ),
                  ),
                  child: NotebookItem(notebook: sampleNotebook),
                );
              },
            ),
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
