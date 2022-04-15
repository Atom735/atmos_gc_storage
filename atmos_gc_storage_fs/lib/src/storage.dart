import 'package:gcloud/storage.dart';

class AtmosGcStorageFs implements Storage {
  @override
  Bucket bucket(
    String bucketName, {
    PredefinedAcl? defaultPredefinedObjectAcl,
    Acl? defaultObjectAcl,
  }) {
    // TODO: implement bucket
    throw UnimplementedError();
  }

  @override
  Future<bool> bucketExists(String bucketName) {
    // TODO: implement bucketExists
    throw UnimplementedError();
  }

  @override
  Future<BucketInfo> bucketInfo(String bucketName) {
    // TODO: implement bucketInfo
    throw UnimplementedError();
  }

  @override
  Future copyObject(String src, String dest) {
    // TODO: implement copyObject
    throw UnimplementedError();
  }

  @override
  Future createBucket(String bucketName,
      {PredefinedAcl? predefinedAcl, Acl? acl}) {
    // TODO: implement createBucket
    throw UnimplementedError();
  }

  @override
  Future deleteBucket(String bucketName) {
    // TODO: implement deleteBucket
    throw UnimplementedError();
  }

  @override
  Stream<String> listBucketNames() {
    // TODO: implement listBucketNames
    throw UnimplementedError();
  }

  @override
  Future<Page<String>> pageBucketNames({int pageSize = 50}) {
    // TODO: implement pageBucketNames
    throw UnimplementedError();
  }
}
