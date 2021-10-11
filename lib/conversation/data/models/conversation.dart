import 'dart:convert';

import 'package:equatable/equatable.dart';

class Conversation extends Equatable {
  final String id;
  final List<String> members;

  const Conversation({
    required this.id,
    required this.members,
  });

  Conversation copyWith({
    String? id,
    List<String>? members,
  }) {
    return Conversation(
      id: id ?? this.id,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'members': members,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map['id']?.toString() ?? '',
      members: map['members'] != null
          ? List<String>.from(map['members'] as List<String>)
          : <String>[],
    );
  }

  String toJson() => json.encode(toMap());

  factory Conversation.fromJson(String source) => Conversation.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, members];
}
