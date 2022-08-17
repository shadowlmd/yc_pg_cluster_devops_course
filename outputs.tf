output "conection_info" {
  value = {
    "host" = "c-${yandex_mdb_postgresql_cluster.sausage_store.id}.rw.mdb.yandexcloud.net"
    "port" = "6432"
  }
}

output "passwords" {
  value = {
    "sausage_store" = "${random_string.sausage_db_passwords[0].result}"
    "read_user"     = "${random_string.sausage_db_passwords[1].result}"
    "write_user"    = "${random_string.sausage_db_passwords[2].result}"
    "admin_user"    = "${random_string.sausage_db_passwords[3].result}"
  }
}
