import 'package:gcloud/storage.dart';

class AtmosObjectInfo implements ObjectInfo {
  @override
  // TODO: implement crc32CChecksum
  int get crc32CChecksum => throw UnimplementedError();

  @override
  // TODO: implement downloadLink
  Uri get downloadLink => throw UnimplementedError();

  @override
  // TODO: implement etag
  String get etag => throw UnimplementedError();

  @override
  // TODO: implement generation
  ObjectGeneration get generation => throw UnimplementedError();

  @override
  // TODO: implement length
  int get length => throw UnimplementedError();

  @override
  // TODO: implement md5Hash
  List<int> get md5Hash => throw UnimplementedError();

  @override
  // TODO: implement metadata
  ObjectMetadata get metadata => throw UnimplementedError();

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();

  @override
  // TODO: implement updated
  DateTime get updated => throw UnimplementedError();
}
