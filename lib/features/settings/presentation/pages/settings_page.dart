import 'package:flutter/material.dart';
import 'package:notebooks/core/widgets/k_button.dart';

import '../../../../data/repositories/data_repository.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  final dbClose = DataRepository.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Center(
          child: KPrimaryButton(
            text: 'Close Database',
            onPressed: () {
              dbClose.closeDatabase();
            },
          ),
        ),
      ),
    );
  }
}
