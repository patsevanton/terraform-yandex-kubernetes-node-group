variable "folder_id" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "memory" {
  type = number
}

variable "cpu" {
  type = number
}

variable "cpu_type" {
  type    = string
  default = "standard-v3"
}

variable "disk" {
  type = number
}

variable "disk_type" {
  type    = string
  default = "network-ssd"
}

variable "num" {
  type        = number
  description = "Number of nodes"
  default     = 1
}

variable "max_num" {
  type        = number
  description = "Number of nodes"
  default     = 1
}

variable "k8s_version" {
  type        = string
  description = "Version of nodes"
}

variable "pool_name" {
  type        = string
  description = "Pool node name"
}

variable "subnet_id" {
  type    = list(string)
  default = null
}

variable "nat" {
  type    = string
  default = false
}

variable "max_unavailable" {
  type    = number
  default = 0
}

variable "max_expansion" {
  type    = number
  default = 2
}

variable "k8s_zone" {
  description = "Set zone"
  type        = list(string)
  default     = ["ru-central1-b"]
}


variable "node_taints" {
  description = "List taint rules"
  type        = list(string)
  default     = []
}

variable "maintenance_window_day" {
  type    = string
  default = "saturday"
}

variable "maintenance_window_start_time" {
  type    = string
  default = "03:00"
}

variable "maintenance_window_duration" {
  type    = string
  default = "2h00m"
}

variable "node_labels" {
  type = map(string)
  default = {
    "failure-domain.beta.kubernetes.io/region" = "yandex"
  }
}

variable "security_group_ids" {
  type        = list(string)
  default     = null
  description = "List of attached security groups id"
}

### cloud-config
variable "serial" {
  type        = string
  default     = "0"
  description = "Serial console"
}

variable "ssh_keys_default" {
  type        = list(string)
  description = "cloud-config ssh keys"
}

variable "ssh_keys_additional" {
  type        = list(string)
  default     = []
  description = "cloud-config additional ssh keys"
}

variable "container_runtime" {
  type    = string
  default = "containerd"
}

variable "description" {
  type = string
}

variable "preemptible_enable" {
  type = bool
}

variable "auto_upgrade_enable" {
  type = bool
}

variable "auto_repair_enable" {
  type = bool
}

variable "node_group_name" {
  default = ""
}

variable "platform_id" {
  default = ""
}

variable "nat_enable" {
  default = ""
}

variable "disk_size" {
  default = ""
}

variable "core_fraction" {
  default = ""
}