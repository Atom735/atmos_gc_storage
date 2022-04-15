import 'dart:convert';

import 'package:gcloud/storage.dart';
import 'package:meta/meta.dart';

@immutable
class AclJsonEncoder extends Converter<Acl, List> {
  @literal
  const AclJsonEncoder();

  @override
  List convert(Acl input) =>
      input.entries.map(const AclEntryJsonEncoder().convert).toList();
}

@immutable
class AclJsonDecoder extends Converter<List, Acl> {
  @literal
  const AclJsonDecoder();

  @override
  Acl convert(List input) =>
      Acl(input.cast<Map>().map(const AclEntryJsonDecoder().convert));
}

@immutable
class AclEntryJsonEncoder extends Converter<AclEntry, Map> {
  @literal
  const AclEntryJsonEncoder();

  @override
  Map convert(AclEntry input) => {
        'scope': const AclScopeJsonEncoder().convert(input.scope),
        'permission':
            const AclPermissionJsonEncoder().convert(input.permission),
      };
}

@immutable
class AclEntryJsonDecoder extends Converter<Map, AclEntry> {
  @literal
  const AclEntryJsonDecoder();

  @override
  AclEntry convert(Map input) => AclEntry(
        const AclScopeJsonDecoder().convert(input['scope']),
        const AclPermissionJsonDecoder().convert(input['permission']),
      );
}

@immutable
class AclScopeJsonEncoder extends Converter<AclScope, String> {
  @literal
  const AclScopeJsonEncoder();

  @override
  String convert(AclScope input) {
    if (input is StorageIdScope) {
      return 'storage/${input.storageId}';
    }
    if (input is AccountScope) {
      return 'account/${input.email}';
    }
    if (input is GroupScope) {
      return 'group/${input.group}';
    }
    if (input is DomainScope) {
      return 'domain/${input.domain}';
    }
    if (input is ProjectScope) {
      return 'project/${input.role}/${input.project}';
    }
    // if (input is OpaqueScope) {
    //   return 'opaque/${input.toString()}';
    // }
    if (input is AllAuthenticatedScope) {
      return 'allAuthenticatedUsers';
    }
    if (input is AllUsersScope) {
      return 'allUsers';
    }
    return 'opaque/${input.toString()}';
  }
}

@immutable
class AclScopeJsonDecoder extends Converter<String, AclScope> {
  @literal
  const AclScopeJsonDecoder();

  @override
  AclScope convert(String input) {
    if (input.startsWith('storage/')) {
      return StorageIdScope(input.substring('storage/'.length));
    }
    if (input.startsWith('account/')) {
      return AccountScope(input.substring('account/'.length));
    }
    if (input.startsWith('group/')) {
      return GroupScope(input.substring('group/'.length));
    }
    if (input.startsWith('domain/')) {
      return DomainScope(input.substring('domain/'.length));
    }
    if (input.startsWith('project/')) {
      final i = input.lastIndexOf('/');
      return ProjectScope(
        input.substring(i + 1),
        input.substring('project/'.length, i),
      );
    }
    if (input.startsWith('opaque/')) {
      return OpaqueScope(input.substring('opaque/'.length));
    }
    if (input == 'allAuthenticatedUsers') {
      return AclScope.allAuthenticated;
    }
    if (input == 'allUsers') {
      return AclScope.allUsers;
    }
    if (input.startsWith('AclScope(')) {
      return OpaqueScope(input.substring('AclScope('.length, input.length - 1));
    }
    return OpaqueScope(input);
  }
}

@immutable
class AclPermissionJsonEncoder extends Converter<AclPermission, String> {
  @literal
  const AclPermissionJsonEncoder();

  @override
  String convert(AclPermission input) {
    if (input == AclPermission.FULL_CONTROL) {
      return 'full';
    }
    if (input == AclPermission.WRITE) {
      return 'write';
    }
    // if (input == AclPermission.READ) {
    //   return 'read';
    // }
    return 'read';
  }
}

@immutable
class AclPermissionJsonDecoder extends Converter<String, AclPermission> {
  @literal
  const AclPermissionJsonDecoder();

  @override
  AclPermission convert(String input) {
    switch (input) {
      case 'full':
        return AclPermission.FULL_CONTROL;
      case 'write':
        return AclPermission.WRITE;
      default:
        return AclPermission.READ;
    }
  }
}
