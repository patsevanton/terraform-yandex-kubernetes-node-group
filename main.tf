resource "yandex_kubernetes_node_group" "k8s_node_group" {
  cluster_id  = var.cluster_id
  name        = var.node_group_name
  description = var.description
  version     = var.k8s_version

  labels = var.node_labels

  node_labels = var.node_labels

  instance_template {
    platform_id = var.platform_id

    network_interface {
      nat        = var.nat_enable
      subnet_ids = var.subnet_id
    }


    resources {
      cores         = var.cpu
      memory        = var.memory
      core_fraction = var.core_fraction
    }

    boot_disk {
      type = var.disk_type
      size = var.disk_size
    }

    scheduling_policy {
      preemptible = var.preemptible_enable
    }

    container_runtime {
      type = var.container_runtime
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }

  }

  scale_policy {
    fixed_scale {
      size = 1
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
    auto_upgrade = var.auto_upgrade_enable
    auto_repair  = var.auto_repair_enable


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
