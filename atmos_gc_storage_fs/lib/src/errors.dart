class AtmosGcStorageError extends Error {
  AtmosGcStorageError._(this.code);

  final int code;

  @override
  String toString() => 'AtmosGcStorageError($code)';
}

class AtmosGcStorageBucketNameError extends AtmosGcStorageError {
  AtmosGcStorageBucketNameError() : super._(1);

  @override
  String toString() => '${super.toString()}: invalid bucket name';
}

class AtmosGcStorageBucketNotExistsError extends AtmosGcStorageError {
  AtmosGcStorageBucketNotExistsError() : super._(2);

  @override
  String toString() => '${super.toString()}: bucket not exists';
}

class AtmosGcStorageBucketExistsError extends AtmosGcStorageError {
  AtmosGcStorageBucketExistsError() : super._(3);

  @override
  String toString() => '${super.toString()}: bucket exists already';
}
