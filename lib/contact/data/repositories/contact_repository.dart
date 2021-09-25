import 'package:yt_chat/account/data/models/user.dart';
import 'package:yt_chat/contact/data/providers/contact_firebase_provider.dart';

class ContactRepository {
  final ContactFirebaseProvider contactFirebaseProvider;
  ContactRepository({
    required this.contactFirebaseProvider,
  });

  Stream<List<UserDetail>> getUserStream() {
    final contactStream = contactFirebaseProvider.getContactStream();

    return contactStream.map(
      (userMapList) => userMapList
          .map(
            (userMap) => UserDetail.fromMap(userMap),
          )
          .toList(),
    );
  }
}
