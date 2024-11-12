//
//  Generated code. Do not modify.
//  source: error.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use errCodeDescriptor instead')
const ErrCode$json = {
  '1': 'ErrCode',
  '2': [
    {'1': 'Success', '2': 0},
    {'1': 'Fail', '2': 1},
    {'1': 'Unsupported_op', '2': 2},
    {'1': 'Serialize_error', '2': 3},
    {'1': 'Deserialize_error', '2': 4},
    {'1': 'Decompress_error', '2': 5},
    {'1': 'Compress_error', '2': 6},
    {'1': 'Sql_prepare_error', '2': 7},
    {'1': 'Sql_execute_error', '2': 8},
    {'1': 'File_size_set_error', '2': 10000},
    {'1': 'File_permission', '2': 10001},
    {'1': 'File_disk_full', '2': 10002},
    {'1': 'File_partition_size_error', '2': 10003},
    {'1': 'File_permission_or_not_exists', '2': 10004},
    {'1': 'File_hash_calc_error', '2': 10005},
    {'1': 'File_sha256_calc_error', '2': 10006},
    {'1': 'File_md5_calc_error', '2': 10007},
    {'1': 'File_crc32_calc_error', '2': 10008},
    {'1': 'File_blake3_calc_error', '2': 10009},
    {'1': 'File_type_mismatch', '2': 10010},
    {'1': 'File_copy_error', '2': 10011},
    {'1': 'File_not_absolute', '2': 10012},
    {'1': 'File_dst_is_src_subdir', '2': 10013},
    {'1': 'File_not_exists', '2': 10014},
    {'1': 'File_exists', '2': 10015},
    {'1': 'File_not_dir', '2': 10016},
    {'1': 'File_mkdir_error', '2': 10017},
    {'1': 'File_create_symlink_error', '2': 10018},
    {'1': 'Scan_error', '2': 12001},
    {'1': 'Scan_busy', '2': 12002},
    {'1': 'Scan_set_running_error', '2': 12003},
    {'1': 'Scan_interrupted', '2': 12004},
    {'1': 'Scan_dump_error', '2': 12005},
    {'1': 'Repo_not_exists', '2': 13000},
    {'1': 'Repo_uuid_error', '2': 13001},
    {'1': 'Repo_flush_repo_config_error', '2': 13002},
    {'1': 'Repo_create_repo_error', '2': 13003},
    {'1': 'Repo_restore_repo_error', '2': 13004},
    {'1': 'Repo_data_not_exists', '2': 13005},
    {'1': 'Repo_meta_not_exists', '2': 13006},
    {'1': 'Sync_interrupted', '2': 15000},
    {'1': 'User_invalid_name', '2': 17000},
    {'1': 'User_invalid_passwd', '2': 17001},
    {'1': 'User_session_error', '2': 17002},
    {'1': 'User_register_prepare_error', '2': 17003},
    {'1': 'User_register_execute_error', '2': 17004},
    {'1': 'User_register_error', '2': 17005},
    {'1': 'User_delete_prepare_error', '2': 17006},
    {'1': 'User_delete_execute_error', '2': 17007},
    {'1': 'User_delete_error', '2': 17008},
    {'1': 'User_login_prepare_error', '2': 17009},
    {'1': 'User_login_execute_error', '2': 17010},
    {'1': 'User_login_error', '2': 17011},
    {'1': 'User_exists_prepare_error', '2': 17012},
    {'1': 'User_exists_execute_error', '2': 17013},
    {'1': 'User_exists_error', '2': 17014},
    {'1': 'User_exists', '2': 17015},
    {'1': 'User_not_exists', '2': 17016},
    {'1': 'User_change_password_error', '2': 17017},
  ],
};

/// Descriptor for `ErrCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List errCodeDescriptor = $convert.base64Decode(
    'CgdFcnJDb2RlEgsKB1N1Y2Nlc3MQABIICgRGYWlsEAESEgoOVW5zdXBwb3J0ZWRfb3AQAhITCg'
    '9TZXJpYWxpemVfZXJyb3IQAxIVChFEZXNlcmlhbGl6ZV9lcnJvchAEEhQKEERlY29tcHJlc3Nf'
    'ZXJyb3IQBRISCg5Db21wcmVzc19lcnJvchAGEhUKEVNxbF9wcmVwYXJlX2Vycm9yEAcSFQoRU3'
    'FsX2V4ZWN1dGVfZXJyb3IQCBIYChNGaWxlX3NpemVfc2V0X2Vycm9yEJBOEhQKD0ZpbGVfcGVy'
    'bWlzc2lvbhCRThITCg5GaWxlX2Rpc2tfZnVsbBCSThIeChlGaWxlX3BhcnRpdGlvbl9zaXplX2'
    'Vycm9yEJNOEiIKHUZpbGVfcGVybWlzc2lvbl9vcl9ub3RfZXhpc3RzEJROEhkKFEZpbGVfaGFz'
    'aF9jYWxjX2Vycm9yEJVOEhsKFkZpbGVfc2hhMjU2X2NhbGNfZXJyb3IQlk4SGAoTRmlsZV9tZD'
    'VfY2FsY19lcnJvchCXThIaChVGaWxlX2NyYzMyX2NhbGNfZXJyb3IQmE4SGwoWRmlsZV9ibGFr'
    'ZTNfY2FsY19lcnJvchCZThIXChJGaWxlX3R5cGVfbWlzbWF0Y2gQmk4SFAoPRmlsZV9jb3B5X2'
    'Vycm9yEJtOEhYKEUZpbGVfbm90X2Fic29sdXRlEJxOEhsKFkZpbGVfZHN0X2lzX3NyY19zdWJk'
    'aXIQnU4SFAoPRmlsZV9ub3RfZXhpc3RzEJ5OEhAKC0ZpbGVfZXhpc3RzEJ9OEhEKDEZpbGVfbm'
    '90X2RpchCgThIVChBGaWxlX21rZGlyX2Vycm9yEKFOEh4KGUZpbGVfY3JlYXRlX3N5bWxpbmtf'
    'ZXJyb3IQok4SDwoKU2Nhbl9lcnJvchDhXRIOCglTY2FuX2J1c3kQ4l0SGwoWU2Nhbl9zZXRfcn'
    'VubmluZ19lcnJvchDjXRIVChBTY2FuX2ludGVycnVwdGVkEORdEhQKD1NjYW5fZHVtcF9lcnJv'
    'chDlXRIUCg9SZXBvX25vdF9leGlzdHMQyGUSFAoPUmVwb191dWlkX2Vycm9yEMllEiEKHFJlcG'
    '9fZmx1c2hfcmVwb19jb25maWdfZXJyb3IQymUSGwoWUmVwb19jcmVhdGVfcmVwb19lcnJvchDL'
    'ZRIcChdSZXBvX3Jlc3RvcmVfcmVwb19lcnJvchDMZRIZChRSZXBvX2RhdGFfbm90X2V4aXN0cx'
    'DNZRIZChRSZXBvX21ldGFfbm90X2V4aXN0cxDOZRIVChBTeW5jX2ludGVycnVwdGVkEJh1EhcK'
    'EVVzZXJfaW52YWxpZF9uYW1lEOiEARIZChNVc2VyX2ludmFsaWRfcGFzc3dkEOmEARIYChJVc2'
    'VyX3Nlc3Npb25fZXJyb3IQ6oQBEiEKG1VzZXJfcmVnaXN0ZXJfcHJlcGFyZV9lcnJvchDrhAES'
    'IQobVXNlcl9yZWdpc3Rlcl9leGVjdXRlX2Vycm9yEOyEARIZChNVc2VyX3JlZ2lzdGVyX2Vycm'
    '9yEO2EARIfChlVc2VyX2RlbGV0ZV9wcmVwYXJlX2Vycm9yEO6EARIfChlVc2VyX2RlbGV0ZV9l'
    'eGVjdXRlX2Vycm9yEO+EARIXChFVc2VyX2RlbGV0ZV9lcnJvchDwhAESHgoYVXNlcl9sb2dpbl'
    '9wcmVwYXJlX2Vycm9yEPGEARIeChhVc2VyX2xvZ2luX2V4ZWN1dGVfZXJyb3IQ8oQBEhYKEFVz'
    'ZXJfbG9naW5fZXJyb3IQ84QBEh8KGVVzZXJfZXhpc3RzX3ByZXBhcmVfZXJyb3IQ9IQBEh8KGV'
    'VzZXJfZXhpc3RzX2V4ZWN1dGVfZXJyb3IQ9YQBEhcKEVVzZXJfZXhpc3RzX2Vycm9yEPaEARIR'
    'CgtVc2VyX2V4aXN0cxD3hAESFQoPVXNlcl9ub3RfZXhpc3RzEPiEARIgChpVc2VyX2NoYW5nZV'
    '9wYXNzd29yZF9lcnJvchD5hAE=');

