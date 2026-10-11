variable "compute_instance_from_templates" {
  description = <<EOT
Map of compute_instance_from_templates, attributes below
Required:
    - name
    - source_instance_template
Optional:
    - allow_stopping_for_update
    - can_ip_forward
    - deletion_policy
    - deletion_protection
    - description
    - desired_status
    - enable_display
    - hostname
    - key_revocation_action_type
    - labels
    - machine_type
    - metadata
    - metadata_startup_script
    - min_cpu_platform
    - project
    - resource_policies
    - tags
    - zone
    - advanced_machine_features (block):
        - enable_nested_virtualization (optional)
        - enable_uefi_networking (optional)
        - performance_monitoring_unit (optional)
        - threads_per_core (optional)
        - turbo_mode (optional)
        - visible_core_count (optional)
    - attached_disk (block):
        - device_name (optional)
        - disk_encryption_key_raw (optional)
        - disk_encryption_key_rsa (optional)
        - disk_encryption_service_account (optional)
        - force_attach (optional)
        - kms_key_self_link (optional)
        - mode (optional)
        - source (required)
    - boot_disk (block):
        - auto_delete (optional)
        - device_name (optional)
        - disk_encryption_key_raw (optional)
        - disk_encryption_key_rsa (optional)
        - disk_encryption_service_account (optional)
        - force_attach (optional)
        - guest_os_features (optional)
        - initialize_params (optional, block):
            - architecture (optional)
            - enable_confidential_compute (optional)
            - image (optional)
            - labels (optional)
            - provisioned_iops (optional)
            - provisioned_throughput (optional)
            - replica_zones (optional)
            - resource_manager_tags (optional)
            - resource_policies (optional)
            - size (optional)
            - snapshot (optional)
            - source_image_encryption_key (optional, block):
                - kms_key_self_link (optional)
                - kms_key_service_account (optional)
                - raw_key (optional)
                - rsa_encrypted_key (optional)
            - source_snapshot_encryption_key (optional, block):
                - kms_key_self_link (optional)
                - kms_key_service_account (optional)
                - raw_key (optional)
                - rsa_encrypted_key (optional)
            - storage_pool (optional)
            - type (optional)
        - interface (optional)
        - kms_key_self_link (optional)
        - mode (optional)
        - source (optional)
    - confidential_instance_config (block):
        - confidential_instance_type (optional)
        - enable_confidential_compute (optional)
    - guest_accelerator (block):
        - count (required)
        - type (required)
    - instance_encryption_key (block):
        - kms_key_self_link (optional)
        - kms_key_service_account (optional)
    - network_interface (block):
        - access_config (optional, block):
            - nat_ip (optional)
            - network_tier (optional)
            - public_ptr_domain_name (optional)
        - alias_ip_range (optional, block):
            - ip_cidr_range (required)
            - subnetwork_range_name (optional)
        - enable_vpc_scoped_dns (optional)
        - igmp_query (optional)
        - internal_ipv6_prefix_length (optional)
        - ipv6_access_config (optional, block):
            - external_ipv6 (optional)
            - external_ipv6_prefix_length (optional)
            - name (optional)
            - network_tier (required)
            - public_ptr_domain_name (optional)
        - ipv6_address (optional)
        - network (optional)
        - network_attachment (optional)
        - network_ip (optional)
        - nic_type (optional)
        - queue_count (optional)
        - stack_type (optional)
        - subnetwork (optional)
        - subnetwork_project (optional)
        - vlan (optional)
    - network_performance_config (block):
        - total_egress_bandwidth_tier (required)
    - params (block):
        - resource_manager_tags (optional)
    - reservation_affinity (block):
        - specific_reservation (optional, block):
            - key (required)
            - values (required)
        - type (required)
    - scheduling (block):
        - automatic_restart (optional)
        - availability_domain (optional)
        - host_error_timeout_seconds (optional)
        - instance_termination_action (optional)
        - local_ssd_recovery_timeout (optional, block):
            - nanos (optional)
            - seconds (required)
        - max_run_duration (optional, block):
            - nanos (optional)
            - seconds (required)
        - min_node_cpus (optional)
        - node_affinities (optional, block):
            - key (required)
            - operator (required)
            - values (required)
        - on_host_maintenance (optional)
        - on_instance_stop_action (optional, block):
            - discard_local_ssd (optional)
        - preemptible (optional)
        - provisioning_model (optional)
        - termination_time (optional)
    - scratch_disk (block):
        - device_name (optional)
        - interface (required)
        - size (optional)
    - service_account (block):
        - email (optional)
        - scopes (required)
    - shielded_instance_config (block):
        - enable_integrity_monitoring (optional)
        - enable_secure_boot (optional)
        - enable_vtpm (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - workload_identity_config (block):
        - identity (optional)
        - identity_certificate_enabled (optional)
EOT

  type = map(object({
    name                       = string
    source_instance_template   = string
    allow_stopping_for_update  = optional(bool)
    can_ip_forward             = optional(bool)
    deletion_policy            = optional(string)
    deletion_protection        = optional(bool)
    description                = optional(string)
    desired_status             = optional(string)
    enable_display             = optional(bool)
    hostname                   = optional(string)
    key_revocation_action_type = optional(string)
    labels                     = optional(map(string))
    machine_type               = optional(string)
    metadata                   = optional(map(string))
    metadata_startup_script    = optional(string)
    min_cpu_platform           = optional(string)
    project                    = optional(string)
    resource_policies          = optional(list(string))
    tags                       = optional(set(string))
    zone                       = optional(string)
    advanced_machine_features = optional(object({
      enable_nested_virtualization = optional(bool)
      enable_uefi_networking       = optional(bool)
      performance_monitoring_unit  = optional(string)
      threads_per_core             = optional(number)
      turbo_mode                   = optional(string)
      visible_core_count           = optional(number)
    }))
    attached_disk = optional(list(object({
      device_name                     = optional(string)
      disk_encryption_key_raw         = optional(string)
      disk_encryption_key_rsa         = optional(string)
      disk_encryption_service_account = optional(string)
      force_attach                    = optional(bool)
      kms_key_self_link               = optional(string)
      mode                            = optional(string)
      source                          = string
    })))
    boot_disk = optional(object({
      auto_delete                     = optional(bool)
      device_name                     = optional(string)
      disk_encryption_key_raw         = optional(string)
      disk_encryption_key_rsa         = optional(string)
      disk_encryption_service_account = optional(string)
      force_attach                    = optional(bool)
      guest_os_features               = optional(list(string))
      initialize_params = optional(object({
        architecture                = optional(string)
        enable_confidential_compute = optional(bool)
        image                       = optional(string)
        labels                      = optional(map(string))
        provisioned_iops            = optional(number)
        provisioned_throughput      = optional(number)
        replica_zones               = optional(list(string))
        resource_manager_tags       = optional(map(string))
        resource_policies           = optional(list(string))
        size                        = optional(number)
        snapshot                    = optional(string)
        source_image_encryption_key = optional(object({
          kms_key_self_link       = optional(string)
          kms_key_service_account = optional(string)
          raw_key                 = optional(string)
          rsa_encrypted_key       = optional(string)
        }))
        source_snapshot_encryption_key = optional(object({
          kms_key_self_link       = optional(string)
          kms_key_service_account = optional(string)
          raw_key                 = optional(string)
          rsa_encrypted_key       = optional(string)
        }))
        storage_pool = optional(string)
        type         = optional(string)
      }))
      interface         = optional(string)
      kms_key_self_link = optional(string)
      mode              = optional(string)
      source            = optional(string)
    }))
    confidential_instance_config = optional(object({
      confidential_instance_type  = optional(string)
      enable_confidential_compute = optional(bool)
    }))
    guest_accelerator = optional(list(object({
      count = number
      type  = string
    })))
    instance_encryption_key = optional(object({
      kms_key_self_link       = optional(string)
      kms_key_service_account = optional(string)
    }))
    network_interface = optional(list(object({
      access_config = optional(list(object({
        nat_ip                 = optional(string)
        network_tier           = optional(string)
        public_ptr_domain_name = optional(string)
      })))
      alias_ip_range = optional(list(object({
        ip_cidr_range         = string
        subnetwork_range_name = optional(string)
      })))
      enable_vpc_scoped_dns       = optional(bool)
      igmp_query                  = optional(string)
      internal_ipv6_prefix_length = optional(number)
      ipv6_access_config = optional(list(object({
        external_ipv6               = optional(string)
        external_ipv6_prefix_length = optional(string)
        name                        = optional(string)
        network_tier                = string
        public_ptr_domain_name      = optional(string)
      })))
      ipv6_address       = optional(string)
      network            = optional(string)
      network_attachment = optional(string)
      network_ip         = optional(string)
      nic_type           = optional(string)
      queue_count        = optional(number)
      stack_type         = optional(string)
      subnetwork         = optional(string)
      subnetwork_project = optional(string)
      vlan               = optional(number)
    })))
    network_performance_config = optional(object({
      total_egress_bandwidth_tier = string
    }))
    params = optional(object({
      resource_manager_tags = optional(map(string))
    }))
    reservation_affinity = optional(object({
      specific_reservation = optional(object({
        key    = string
        values = list(string)
      }))
      type = string
    }))
    scheduling = optional(object({
      automatic_restart           = optional(bool)
      availability_domain         = optional(number)
      host_error_timeout_seconds  = optional(number)
      instance_termination_action = optional(string)
      local_ssd_recovery_timeout = optional(object({
        nanos   = optional(number)
        seconds = number
      }))
      max_run_duration = optional(object({
        nanos   = optional(number)
        seconds = number
      }))
      min_node_cpus = optional(number)
      node_affinities = optional(list(object({
        key      = string
        operator = string
        values   = set(string)
      })))
      on_host_maintenance = optional(string)
      on_instance_stop_action = optional(object({
        discard_local_ssd = optional(bool)
      }))
      preemptible        = optional(bool)
      provisioning_model = optional(string)
      termination_time   = optional(string)
    }))
    scratch_disk = optional(list(object({
      device_name = optional(string)
      interface   = string
      size        = optional(number)
    })))
    service_account = optional(object({
      email  = optional(string)
      scopes = set(string)
    }))
    shielded_instance_config = optional(object({
      enable_integrity_monitoring = optional(bool)
      enable_secure_boot          = optional(bool)
      enable_vtpm                 = optional(bool)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    workload_identity_config = optional(object({
      identity                     = optional(string)
      identity_certificate_enabled = optional(bool)
    }))
  }))
}

