resource "yandex_iam_service_account" "twoingress-k8s-node-group" {
  folder_id = var.folder_id
  name      = "twoingress-k8s-node-group"
}

resource "yandex_resourcemanager_folder_iam_member" "twoingress-k8s-node-group-permissions" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.twoingress-k8s-node-group.id}"
}

resource "yandex_kubernetes_node_group" "twoingress-k8s-node-group" {
  cluster_id  = yandex_kubernetes_cluster.twoingress_k8s_cluster.id
  name        = "twoingress-k8s-node-group"
  description = "twoingress-k8s-node-group"
  version     = "1.23"

  labels = {
    "key" = "value"
  }

  instance_template {
    platform_id = "standard-v3"

    network_interface {
      nat        = true
      subnet_ids = [data.yandex_vpc_subnet.default-ru-central1-a.id]
    }

    resources {
      cores         = 4
      memory        = 8
      core_fraction = 100
    }

    boot_disk {
      type = "network-ssd"
      size = 100
    }

    scheduling_policy {
      preemptible = true
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
    location {
      zone = data.yandex_vpc_subnet.default-ru-central1-a.zone
    }
  }

  maintenance_policy {
    auto_upgrade = true
    auto_repair  = true

    maintenance_window {
      day        = "monday"
      start_time = "15:00"
      duration   = "3h"
    }

    maintenance_window {
      day        = "friday"
      start_time = "10:00"
      duration   = "4h30m"
    }
  }
}