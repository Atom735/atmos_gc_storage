import 'dart:io';

import 'package:gcloud/storage.dart';
import 'package:logging/logging.dart';

import 'bucket.dart';
import 'bucket_info.dart';
import 'errors.dart';
import 'utils.dart';

class AtmosGcStorageFs implements Storage {
  AtmosGcStorageFs(this.rootDir) {
    for (final dir in rootDir.listSync().whereType<Directory>()) {
      final name = p.basename(dir.path);
      buckets[name] = AtmosBucket(rootDir, name);
    }
  }

  /// [Directory] where place all storage data
  final Directory rootDir;

  final logger = Logger('AtmosStorage-FileSystem');

  final buckets = <String, AtmosBucket>{};

  @override
  AtmosBucket bucket(
    String bucketName, {
    PredefinedAcl? defaultPredefinedObjectAcl,
    Acl? defaultObjectAcl,
  }) {
    logger.finest(
      'bucket: "$bucketName" [$defaultPredefinedObjectAcl, $defaultObjectAcl]',
    );
    return buckets[bucketName] ??= AtmosBucket(rootDir, bucketName);
  }

  @override
  Future<bool> bucketExists(String bucketName) async {
    final o = bucket(bucketName).isExist;
    logger.finer(
      'bucketExists: "$bucketName" ($o)',
    );
    return o;
  }

  @override
  Future<BucketInfo> bucketInfo(String bucketName) async {
    final o = bucket(bucketName).bucketInfo;
    logger.finer(
      'bucketInfo: "$bucketName"',
      o,
    );
    return o;
  }

  @override
  Future copyObject(String src, String dest) async {
    deepCopyFiles(bucket(src).dir, bucket(dest).dir);
  }

  static void deepCopyFiles(Directory src, Directory dst) {
    dst.createSync();
    for (final e in src.listSync()) {
      final basename = p.basename(e.path);
      if (e is File) {
        if (basename.startsWith('--')) continue;
        final d = File(p.join(dst.path, basename));
        if (d.existsSync()) {
          d.deleteSync();
        }
        e.copySync(d.path);
      } else if (e is Directory) {
        final d = Directory(p.join(dst.path, basename));
        deepCopyFiles(e, d);
      }
    }
  }

  @override
  Future createBucket(String bucketName,
      {PredefinedAcl? predefinedAcl, Acl? acl}) async {
    final bucket = this.bucket(bucketName);
    if (bucket.isExist) {
      throw AtmosGcStorageBucketExistsError();
    }
    bucket.bucketInfo =
        AtmosBucketInfo(Acl([]), bucketName, DateTime.now(), '', '');
  }

  @override
  Future deleteBucket(String bucketName) async {
    final bucket = this.bucket(bucketName);
    if (!bucket.isExist) {
      throw AtmosGcStorageBucketNotExistsError();
    }
    bucket.dir.deleteSync(recursive: true);
  }

  @override
  Stream<String> listBucketNames() => rootDir
      .list()
      .map((e) => bucket(p.basename(e.path)))
      .where((e) => e.isExist)
      .map((e) => e.bucketName);

  @override
  Future<Page<String>> pageBucketNames({int pageSize = 50}) async {
    final items = await listBucketNames().take(pageSize + 1).toList();
    final isLast = items.length != pageSize + 1;
    return _BucketNamesPage(
        this, pageSize, items.take(pageSize).toList(), isLast);
  }
}

class _BucketNamesPage implements Page<String> {
  _BucketNamesPage(this.storage, this.pageSize, this.items, this.isLast,
      [this.offset = 0]);

  final AtmosGcStorageFs storage;

  final int pageSize;

  @override
  final List<String> items;

  @override
  final bool isLast;

  final int offset;

  @override
  Future<Page<String>> next({int? pageSize}) async {
    pageSize ??= this.pageSize;
    final offset = this.offset + this.items.length;
    final items = await storage
        .listBucketNames()
        .skip(offset)
        .take(pageSize + 1)
        .toList();
    final isLast = items.length != pageSize + 1;
    return _BucketNamesPage(
        storage, pageSize, items.take(pageSize).toList(), isLast, offset);
  }
}
