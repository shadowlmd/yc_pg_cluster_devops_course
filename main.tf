resource "yandex_mdb_postgresql_cluster" "sausage_store" {
  name        = "${local.owner_username}-sausage-store"
  environment = "PRODUCTION"
  network_id  = local.network_id

  config {
    version = 14
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
    postgresql_config = {
      max_connections = 300
    }
  }

  dynamic "host" {
    for_each = local.availability_zones
    content {
      zone             = host.value.zone
      subnet_id        = host.value.subnet
      assign_public_ip = true
    }
  }
}

resource "yandex_mdb_postgresql_database" "pg_db_sauge_store" {
  cluster_id = yandex_mdb_postgresql_cluster.sausage_store.id
  name       = "sausage_store"
  owner      = yandex_mdb_postgresql_user.pg_user_sauage_store.name
}

resource "yandex_mdb_postgresql_user" "pg_user_sauage_store" {
  cluster_id = yandex_mdb_postgresql_cluster.sausage_store.id
  name       = "sausage_store"
  password   = random_string.sausage_db_passwords[0].result
  conn_limit = 100
}

resource "yandex_mdb_postgresql_user" "pg_user_read_user" {
  cluster_id = yandex_mdb_postgresql_cluster.sausage_store.id
  name       = "read_user"
  password   = random_string.sausage_db_passwords[1].result
  permission {
    database_name = yandex_mdb_postgresql_database.pg_db_sauge_store.name
  }
}

resource "yandex_mdb_postgresql_user" "pg_user_write_user" {
  cluster_id = yandex_mdb_postgresql_cluster.sausage_store.id
  name       = "write_user"
  password   = random_string.sausage_db_passwords[2].result
  permission {
    database_name = yandex_mdb_postgresql_database.pg_db_sauge_store.name
  }
}

resource "yandex_mdb_postgresql_user" "pg_user_admin_user" {
  cluster_id = yandex_mdb_postgresql_cluster.sausage_store.id
  name       = "admin_user"
  password   = random_string.sausage_db_passwords[3].result
  permission {
    database_name = yandex_mdb_postgresql_database.pg_db_sauge_store.name
  }
}

resource "random_string" "sausage_db_passwords" {
  count   = 4
  length  = 32
  special = false
}
