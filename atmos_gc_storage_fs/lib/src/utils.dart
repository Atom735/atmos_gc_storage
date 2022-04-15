import 'package:path/path.dart' as path;

import 'errors.dart';

final p = path.context;

final _bucketNameCodeUnits = '-_.abcdefghijklmnopqrstuvwxyz'.codeUnits;

bool isValidBucketName(String bucketName) {
  if (bucketName.length > 222 ||
      bucketName.length < 3 ||
      bucketName.codeUnits.every(_bucketNameCodeUnits.contains)) {
    return false;
  }
  final segments = bucketName.split('.');
  if (segments.contains('')) {
    return false;
  }
  return true;
}

/// can throw [AtmosGcStorageBucketNameError]
void validateBucketName(String bucketName) {
  if (isValidBucketName(bucketName)) {
    throw AtmosGcStorageBucketNameError();
  }
}
