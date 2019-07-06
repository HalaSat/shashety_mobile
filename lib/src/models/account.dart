import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

enum AccountStatus {
  signedIn,
  signedOut,
}

class AccountModel extends Model {
  AccountStatus _status = AccountStatus.signedOut;
  FirebaseUser _user;

  AccountStatus get status => _status;
  FirebaseUser get user => _user;

  set status(AccountStatus s) {
    _status = s;
    notifyListeners();
  }

  set user(FirebaseUser u) {
    _user = u;
    notifyListeners();
  }
}
