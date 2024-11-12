//
//  Generated code. Do not modify.
//  source: error.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrCode extends $pb.ProtobufEnum {
  static const ErrCode Success = ErrCode._(0, _omitEnumNames ? '' : 'Success');
  static const ErrCode Fail = ErrCode._(1, _omitEnumNames ? '' : 'Fail');
  static const ErrCode Unsupported_op = ErrCode._(2, _omitEnumNames ? '' : 'Unsupported_op');
  static const ErrCode Serialize_error = ErrCode._(3, _omitEnumNames ? '' : 'Serialize_error');
  static const ErrCode Deserialize_error = ErrCode._(4, _omitEnumNames ? '' : 'Deserialize_error');
  static const ErrCode Decompress_error = ErrCode._(5, _omitEnumNames ? '' : 'Decompress_error');
  static const ErrCode Compress_error = ErrCode._(6, _omitEnumNames ? '' : 'Compress_error');
  static const ErrCode Sql_prepare_error = ErrCode._(7, _omitEnumNames ? '' : 'Sql_prepare_error');
  static const ErrCode Sql_execute_error = ErrCode._(8, _omitEnumNames ? '' : 'Sql_execute_error');
  static const ErrCode File_size_set_error = ErrCode._(10000, _omitEnumNames ? '' : 'File_size_set_error');
  static const ErrCode File_permission = ErrCode._(10001, _omitEnumNames ? '' : 'File_permission');
  static const ErrCode File_disk_full = ErrCode._(10002, _omitEnumNames ? '' : 'File_disk_full');
  static const ErrCode File_partition_size_error = ErrCode._(10003, _omitEnumNames ? '' : 'File_partition_size_error');
  static const ErrCode File_permission_or_not_exists = ErrCode._(10004, _omitEnumNames ? '' : 'File_permission_or_not_exists');
  static const ErrCode File_hash_calc_error = ErrCode._(10005, _omitEnumNames ? '' : 'File_hash_calc_error');
  static const ErrCode File_sha256_calc_error = ErrCode._(10006, _omitEnumNames ? '' : 'File_sha256_calc_error');
  static const ErrCode File_md5_calc_error = ErrCode._(10007, _omitEnumNames ? '' : 'File_md5_calc_error');
  static const ErrCode File_crc32_calc_error = ErrCode._(10008, _omitEnumNames ? '' : 'File_crc32_calc_error');
  static const ErrCode File_blake3_calc_error = ErrCode._(10009, _omitEnumNames ? '' : 'File_blake3_calc_error');
  static const ErrCode File_type_mismatch = ErrCode._(10010, _omitEnumNames ? '' : 'File_type_mismatch');
  static const ErrCode File_copy_error = ErrCode._(10011, _omitEnumNames ? '' : 'File_copy_error');
  static const ErrCode File_not_absolute = ErrCode._(10012, _omitEnumNames ? '' : 'File_not_absolute');
  static const ErrCode File_dst_is_src_subdir = ErrCode._(10013, _omitEnumNames ? '' : 'File_dst_is_src_subdir');
  static const ErrCode File_not_exists = ErrCode._(10014, _omitEnumNames ? '' : 'File_not_exists');
  static const ErrCode File_exists = ErrCode._(10015, _omitEnumNames ? '' : 'File_exists');
  static const ErrCode File_not_dir = ErrCode._(10016, _omitEnumNames ? '' : 'File_not_dir');
  static const ErrCode File_mkdir_error = ErrCode._(10017, _omitEnumNames ? '' : 'File_mkdir_error');
  static const ErrCode File_create_symlink_error = ErrCode._(10018, _omitEnumNames ? '' : 'File_create_symlink_error');
  static const ErrCode Scan_error = ErrCode._(12001, _omitEnumNames ? '' : 'Scan_error');
  static const ErrCode Scan_busy = ErrCode._(12002, _omitEnumNames ? '' : 'Scan_busy');
  static const ErrCode Scan_set_running_error = ErrCode._(12003, _omitEnumNames ? '' : 'Scan_set_running_error');
  static const ErrCode Scan_interrupted = ErrCode._(12004, _omitEnumNames ? '' : 'Scan_interrupted');
  static const ErrCode Scan_dump_error = ErrCode._(12005, _omitEnumNames ? '' : 'Scan_dump_error');
  static const ErrCode Repo_not_exists = ErrCode._(13000, _omitEnumNames ? '' : 'Repo_not_exists');
  static const ErrCode Repo_uuid_error = ErrCode._(13001, _omitEnumNames ? '' : 'Repo_uuid_error');
  static const ErrCode Repo_flush_repo_config_error = ErrCode._(13002, _omitEnumNames ? '' : 'Repo_flush_repo_config_error');
  static const ErrCode Repo_create_repo_error = ErrCode._(13003, _omitEnumNames ? '' : 'Repo_create_repo_error');
  static const ErrCode Repo_restore_repo_error = ErrCode._(13004, _omitEnumNames ? '' : 'Repo_restore_repo_error');
  static const ErrCode Repo_data_not_exists = ErrCode._(13005, _omitEnumNames ? '' : 'Repo_data_not_exists');
  static const ErrCode Repo_meta_not_exists = ErrCode._(13006, _omitEnumNames ? '' : 'Repo_meta_not_exists');
  static const ErrCode Sync_interrupted = ErrCode._(15000, _omitEnumNames ? '' : 'Sync_interrupted');
  static const ErrCode User_invalid_name = ErrCode._(17000, _omitEnumNames ? '' : 'User_invalid_name');
  static const ErrCode User_invalid_passwd = ErrCode._(17001, _omitEnumNames ? '' : 'User_invalid_passwd');
  static const ErrCode User_session_error = ErrCode._(17002, _omitEnumNames ? '' : 'User_session_error');
  static const ErrCode User_register_prepare_error = ErrCode._(17003, _omitEnumNames ? '' : 'User_register_prepare_error');
  static const ErrCode User_register_execute_error = ErrCode._(17004, _omitEnumNames ? '' : 'User_register_execute_error');
  static const ErrCode User_register_error = ErrCode._(17005, _omitEnumNames ? '' : 'User_register_error');
  static const ErrCode User_delete_prepare_error = ErrCode._(17006, _omitEnumNames ? '' : 'User_delete_prepare_error');
  static const ErrCode User_delete_execute_error = ErrCode._(17007, _omitEnumNames ? '' : 'User_delete_execute_error');
  static const ErrCode User_delete_error = ErrCode._(17008, _omitEnumNames ? '' : 'User_delete_error');
  static const ErrCode User_login_prepare_error = ErrCode._(17009, _omitEnumNames ? '' : 'User_login_prepare_error');
  static const ErrCode User_login_execute_error = ErrCode._(17010, _omitEnumNames ? '' : 'User_login_execute_error');
  static const ErrCode User_login_error = ErrCode._(17011, _omitEnumNames ? '' : 'User_login_error');
  static const ErrCode User_exists_prepare_error = ErrCode._(17012, _omitEnumNames ? '' : 'User_exists_prepare_error');
  static const ErrCode User_exists_execute_error = ErrCode._(17013, _omitEnumNames ? '' : 'User_exists_execute_error');
  static const ErrCode User_exists_error = ErrCode._(17014, _omitEnumNames ? '' : 'User_exists_error');
  static const ErrCode User_exists = ErrCode._(17015, _omitEnumNames ? '' : 'User_exists');
  static const ErrCode User_not_exists = ErrCode._(17016, _omitEnumNames ? '' : 'User_not_exists');
  static const ErrCode User_change_password_error = ErrCode._(17017, _omitEnumNames ? '' : 'User_change_password_error');

  static const $core.List<ErrCode> values = <ErrCode> [
    Success,
    Fail,
    Unsupported_op,
    Serialize_error,
    Deserialize_error,
    Decompress_error,
    Compress_error,
    Sql_prepare_error,
    Sql_execute_error,
    File_size_set_error,
    File_permission,
    File_disk_full,
    File_partition_size_error,
    File_permission_or_not_exists,
    File_hash_calc_error,
    File_sha256_calc_error,
    File_md5_calc_error,
    File_crc32_calc_error,
    File_blake3_calc_error,
    File_type_mismatch,
    File_copy_error,
    File_not_absolute,
    File_dst_is_src_subdir,
    File_not_exists,
    File_exists,
    File_not_dir,
    File_mkdir_error,
    File_create_symlink_error,
    Scan_error,
    Scan_busy,
    Scan_set_running_error,
    Scan_interrupted,
    Scan_dump_error,
    Repo_not_exists,
    Repo_uuid_error,
    Repo_flush_repo_config_error,
    Repo_create_repo_error,
    Repo_restore_repo_error,
    Repo_data_not_exists,
    Repo_meta_not_exists,
    Sync_interrupted,
    User_invalid_name,
    User_invalid_passwd,
    User_session_error,
    User_register_prepare_error,
    User_register_execute_error,
    User_register_error,
    User_delete_prepare_error,
    User_delete_execute_error,
    User_delete_error,
    User_login_prepare_error,
    User_login_execute_error,
    User_login_error,
    User_exists_prepare_error,
    User_exists_execute_error,
    User_exists_error,
    User_exists,
    User_not_exists,
    User_change_password_error,
  ];

  static final $core.Map<$core.int, ErrCode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ErrCode? valueOf($core.int value) => _byValue[value];

  const ErrCode._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
