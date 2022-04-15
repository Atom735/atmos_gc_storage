import 'dart:async';

import 'package:gcloud/storage.dart';

class AtmosBucket implements Bucket {
  @override
  String absoluteObjectName(String objectName) {
    // TODO: implement absoluteObjectName
    throw UnimplementedError();
  }

  @override
  // TODO: implement bucketName
  String get bucketName => throw UnimplementedError();

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
