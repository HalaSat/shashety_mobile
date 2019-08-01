import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:shashety_mobile/src/models/account.dart';

import 'src/pages/app.dart';
import 'package:rate_my_app/rate_my_app.dart';

RateMyApp rateMyApp = RateMyApp(
  minDays: 0,
  minLaunches: 1,
  remindDays: 7,
  remindLaunches: 10,
);

void main() {
  final AccountModel account = AccountModel();

  runApp(
    ScopedModel<AccountModel>(
      model: account,
      child: App(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          title: 'قيم التطبيق',
          message: 'اذا اعجبك التطبيق يرجى تقييمه، لن يآخذ اكثر من دقيقه وسيساعدنا على تطوير التطبيق',
          rateButton: 'تقييم',
          noButton: 'لا شكرا',
          laterButton: 'ربما لاحقا',
        );
      }
    });

    return App();
  }
}
