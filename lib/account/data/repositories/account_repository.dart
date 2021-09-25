import 'package:yt_chat/account/account.dart';
import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/utilities/firebase_keys.dart';

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
    required String username,
  }) async {
    final isAvailable =
        await accountFirebaseProvider.isUserNameAvailable(username: username);
    return isAvailable;
  }

  Future<UserDetail> getUserDetail({required String uid}) async {
    final userDetailMap = await accountFirebaseProvider.getUserDetail(uid: uid);

    return UserDetail(
        uid: uid,
        username: userDetailMap != null
            ? userDetailMap[FirebaseKeys.username].toString()
            : '');
  }
}
