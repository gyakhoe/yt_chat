import 'package:yt_chat/account/account.dart';
import 'package:yt_chat/account/data/models/user.dart';

class AccountRepository {
  final AccountFirebaseProvider accountFirebaseProvider;

  AccountRepository({
    required this.accountFirebaseProvider,
  });

  Future<void> addUser({
    required UserDetail userDetail,
  }) async {
    await accountFirebaseProvider.addUser(
      uid: userDetail.uid,
      userDetailMap: userDetail.toMap(),
    );
  }

  Future<bool> isUsernameAvailable({
    required UserDetail userDetail,
  }) async {
    final isAvailable =
        await accountFirebaseProvider.isRegistered(uid: userDetail.uid);
    return isAvailable;
  }

  Future<bool> isRegistered({
    required String uid,
  }) async {
    return accountFirebaseProvider.isRegistered(uid: uid);
  }
}
