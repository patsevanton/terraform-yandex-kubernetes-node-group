resource "yandex_kubernetes_node_group" "k8s_node_group" {
  cluster_id  = var.cluster_id
  name        = var.pool_name
  description = "pool for applications"
  version     = var.k8s_version

  labels = var.node_labels

  node_labels = var.node_labels

  instance_template {
    platform_id = var.cpu_type

    network_interface {
      nat                = var.nat
      subnet_ids         = var.subnet_id
      security_group_ids = var.security_group_ids
    }


    resources {
      memory = var.memory
      cores  = var.cpu
    }

    boot_disk {
      type = var.disk_type
      size = var.disk
    }

    scheduling_policy {
      preemptible = false
    }

    container_runtime {
      type = var.container_runtime
    }

    metadata = {
      ssh-keys           = templatefile("${path.module}/ssh-keys.tpl", {
          ssh_keys_default    = var.ssh_keys_default, 
          ssh_keys_additional = var.ssh_keys_additional
        }
      )
      serial-port-enable = var.serial
    }

  }

  scale_policy {
    auto_scale {
      min     = var.num
      max     = var.max_num
      initial = var.num
    }
  }

  allocation_policy {
    dynamic "location" {
      for_each = var.k8s_zone
      content {
        zone = location.value
      }

    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true


    maintenance_window {
      day        = var.maintenance_window_day
      start_time = var.maintenance_window_start_time
      duration   = var.maintenance_window_duration
    }
  }
  deploy_policy {
    max_unavailable = var.max_unavailable
    max_expansion   = var.max_expansion
  }

  node_taints = var.node_taints
}
