// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gcloud/storage.dart';
import 'package:meta/meta.dart';

import 'converters/converters_acl.dart';

@immutable
class AtmosBucketInfo implements BucketInfo {
  const AtmosBucketInfo(
    this.acl,
    this.bucketName,
    this.created,
    this.etag,
    this.id,
  );

  @override
  final Acl acl;

  @override
  final String bucketName;

  @override
  final DateTime created;

  @override
  final String etag;

  @override
  final String id;

  // ignore: sort_constructors_first
  factory AtmosBucketInfo.fromMap(Map<String, dynamic> map) => AtmosBucketInfo(
        const AclJsonDecoder().convert(map['acl']),
        map['bucketName'] as String,
        DateTime.parse(map['created'] as String),
        map['etag'] as String,
        map['id'] as String,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        'acl': const AclJsonEncoder().convert(acl),
        'bucketName': bucketName,
        'created': created.toIso8601String(),
        'etag': etag,
        'id': id,
      };

  @override
  String toString() =>
      '''AtmosBucketInfo(acl: $acl, bucketName: $bucketName, created: $created, etag: $etag, id: $id)''';
}
