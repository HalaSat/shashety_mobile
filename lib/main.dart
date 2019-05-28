import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:shashety_mobile/src/models/account.dart';

import 'src/pages/app.dart';

void main() {
  final AccountModel account = AccountModel();

  runApp(ScopedModel<AccountModel>(
    model: account,
    child: App(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}
