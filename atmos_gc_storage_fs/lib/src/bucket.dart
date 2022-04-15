import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gcloud/storage.dart';

import 'bucket_info.dart';
import 'utils.dart';

class AtmosBucket implements Bucket {
  AtmosBucket(Directory rootDir, this.bucketName)
      : dir = Directory(p.join(rootDir.path, bucketName)),
        file = File(p.join(rootDir.path, bucketName, '--bucketInfo.json')) {
    validateBucketName(bucketName);
  }

  @override
  final String bucketName;

  final Directory dir;

  final File file;

  bool get isExist => file.existsSync();

  AtmosBucketInfo get bucketInfo => AtmosBucketInfo.fromMap(
      const JsonDecoder().convert(file.readAsStringSync()));

  set bucketInfo(AtmosBucketInfo info) => file.writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(info.toMap()));

  @override
  String absoluteObjectName(String objectName) =>
      'gs://b/$bucketName/o/$objectName';

  @override
  Future delete(String name) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<ObjectInfo> info(String name) {
    // TODO: implement info
    throw UnimplementedError();
  }

  @override
  Stream<BucketEntry> list({String? prefix, String? delimiter}) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future<Page<BucketEntry>> page(
      {String? prefix, String? delimiter, int pageSize = 50}) {
    // TODO: implement page
    throw UnimplementedError();
  }

  @override
  Stream<List<int>> read(String objectName, {int? offset, int? length}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future updateMetadata(String objectName, ObjectMetadata metadata) {
    // TODO: implement updateMetadata
    throw UnimplementedError();
  }

  @override
  StreamSink<List<int>> write(String objectName,
      {int? length,
      ObjectMetadata? metadata,
      Acl? acl,
      PredefinedAcl? predefinedAcl,
      String? contentType}) {
    // TODO: implement write
    throw UnimplementedError();
  }

  @override
  Future<ObjectInfo> writeBytes(String name, List<int> bytes,
      {ObjectMetadata? metadata,
      Acl? acl,
      PredefinedAcl? predefinedAcl,
      String? contentType}) {
    // TODO: implement writeBytes
    throw UnimplementedError();
  }
}
