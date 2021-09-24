import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDetail extends Equatable {
  final String uid;
  final String username;

  const UserDetail({
    required this.uid,
    required this.username,
  });

  UserDetail copyWith({
    String? uid,
    String? username,
  }) {
    return UserDetail(
      uid: uid ?? this.uid,
      username: username ?? this.username,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'uid': uid,
      'username': username,
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(
      uid: map['uid']?.toString() ?? '',
      username: map['username']?.toString() ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetail.fromJson(String source) => UserDetail.fromMap(
        json.decode(source) as Map<String, String>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [uid, username];
}
