import 'package:flutter/material.dart';

class FavoriteNotes extends StatelessWidget {
  const FavoriteNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('Favorite Notes'),
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 78,
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
