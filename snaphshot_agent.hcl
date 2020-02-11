{
  "snapshot_agent": {
    "http_addr": "consul-consul-server:8500",
    "token": "",
    "datacenter": "dc1",
    "ca_file": "",
    "ca_path": "",
    "cert_file": "",
    "key_file": "",
    "tls_server_name": "",
    "log": {
      "level": "INFO",
      "enable_syslog": false,
      "syslog_facility": "LOCAL0"
    },
    "snapshot": {
      "interval": "1h",
      "retain": 5,
      "stale": false,
      "service": "consul-snapshot",
      "deregister_after": "48h",
      "lock_key": "consul-snapshot/lock",
      "max_failures": 3
    },
    "local_storage": {
      "path": "/tmp/"
    }
  },
  "other_storage_examples" : {
    "aws_storage": {
      "access_key_id": "",
      "secret_access_key": "",
      "s3_region": "",
      "s3_bucket": "",
      "s3_key_prefix": "consul-snapshot",
      "s3_server_side_encryption": false,
      "s3_static_snapshot_name": ""
    },
    "azure_blob_storage" : {
      "account_name": "",
      "account_key": "",
      "container_name": ""
    },
    "google_storage": {
      "bucket": ""
    }
  }
}