resource "google_compute_instance_from_template" "compute_instance_from_templates" {
  for_each = var.compute_instance_from_templates

  name                       = each.value.name
  source_instance_template   = each.value.source_instance_template
  allow_stopping_for_update  = each.value.allow_stopping_for_update
  can_ip_forward             = each.value.can_ip_forward
  deletion_policy            = each.value.deletion_policy
  deletion_protection        = each.value.deletion_protection
  description                = each.value.description
  desired_status             = each.value.desired_status
  enable_display             = each.value.enable_display
  hostname                   = each.value.hostname
  key_revocation_action_type = each.value.key_revocation_action_type
  labels                     = each.value.labels
  machine_type               = each.value.machine_type
  metadata                   = each.value.metadata
  metadata_startup_script    = each.value.metadata_startup_script
  min_cpu_platform           = each.value.min_cpu_platform
  project                    = each.value.project
  resource_policies          = each.value.resource_policies
  tags                       = each.value.tags
  zone                       = each.value.zone

  dynamic "advanced_machine_features" {
    for_each = each.value.advanced_machine_features != null ? [each.value.advanced_machine_features] : []
    content {
      enable_nested_virtualization = advanced_machine_features.value.enable_nested_virtualization
      enable_uefi_networking       = advanced_machine_features.value.enable_uefi_networking
      performance_monitoring_unit  = advanced_machine_features.value.performance_monitoring_unit
      threads_per_core             = advanced_machine_features.value.threads_per_core
      turbo_mode                   = advanced_machine_features.value.turbo_mode
      visible_core_count           = advanced_machine_features.value.visible_core_count
    }
  }

  dynamic "attached_disk" {
    for_each = each.value.attached_disk != null ? each.value.attached_disk : []
    content {
      device_name                     = attached_disk.value.device_name
      disk_encryption_key_raw         = attached_disk.value.disk_encryption_key_raw
      disk_encryption_key_rsa         = attached_disk.value.disk_encryption_key_rsa
      disk_encryption_service_account = attached_disk.value.disk_encryption_service_account
      force_attach                    = attached_disk.value.force_attach
      kms_key_self_link               = attached_disk.value.kms_key_self_link
      mode                            = attached_disk.value.mode
      source                          = attached_disk.value.source
    }
  }

  dynamic "boot_disk" {
    for_each = each.value.boot_disk != null ? [each.value.boot_disk] : []
    content {
      auto_delete                     = boot_disk.value.auto_delete
      device_name                     = boot_disk.value.device_name
      disk_encryption_key_raw         = boot_disk.value.disk_encryption_key_raw
      disk_encryption_key_rsa         = boot_disk.value.disk_encryption_key_rsa
      disk_encryption_service_account = boot_disk.value.disk_encryption_service_account
      force_attach                    = boot_disk.value.force_attach
      guest_os_features               = boot_disk.value.guest_os_features
      dynamic "initialize_params" {
        for_each = boot_disk.value.initialize_params != null ? [boot_disk.value.initialize_params] : []
        content {
          architecture                = initialize_params.value.architecture
          enable_confidential_compute = initialize_params.value.enable_confidential_compute
          image                       = initialize_params.value.image
          labels                      = initialize_params.value.labels
          provisioned_iops            = initialize_params.value.provisioned_iops
          provisioned_throughput      = initialize_params.value.provisioned_throughput
          replica_zones               = initialize_params.value.replica_zones
          resource_manager_tags       = initialize_params.value.resource_manager_tags
          resource_policies           = initialize_params.value.resource_policies
          size                        = initialize_params.value.size
          snapshot                    = initialize_params.value.snapshot
          dynamic "source_image_encryption_key" {
            for_each = initialize_params.value.source_image_encryption_key != null ? [initialize_params.value.source_image_encryption_key] : []
            content {
              kms_key_self_link       = source_image_encryption_key.value.kms_key_self_link
              kms_key_service_account = source_image_encryption_key.value.kms_key_service_account
              raw_key                 = source_image_encryption_key.value.raw_key
              rsa_encrypted_key       = source_image_encryption_key.value.rsa_encrypted_key
            }
          }
          dynamic "source_snapshot_encryption_key" {
            for_each = initialize_params.value.source_snapshot_encryption_key != null ? [initialize_params.value.source_snapshot_encryption_key] : []
            content {
              kms_key_self_link       = source_snapshot_encryption_key.value.kms_key_self_link
              kms_key_service_account = source_snapshot_encryption_key.value.kms_key_service_account
              raw_key                 = source_snapshot_encryption_key.value.raw_key
              rsa_encrypted_key       = source_snapshot_encryption_key.value.rsa_encrypted_key
            }
          }
          storage_pool = initialize_params.value.storage_pool
          type         = initialize_params.value.type
        }
      }
      interface         = boot_disk.value.interface
      kms_key_self_link = boot_disk.value.kms_key_self_link
      mode              = boot_disk.value.mode
      source            = boot_disk.value.source
    }
  }

  dynamic "confidential_instance_config" {
    for_each = each.value.confidential_instance_config != null ? [each.value.confidential_instance_config] : []
    content {
      confidential_instance_type  = confidential_instance_config.value.confidential_instance_type
      enable_confidential_compute = confidential_instance_config.value.enable_confidential_compute
    }
  }

  dynamic "guest_accelerator" {
    for_each = each.value.guest_accelerator != null ? each.value.guest_accelerator : []
    content {
      count = guest_accelerator.value.count
      type  = guest_accelerator.value.type
    }
  }

  dynamic "instance_encryption_key" {
    for_each = each.value.instance_encryption_key != null ? [each.value.instance_encryption_key] : []
    content {
      kms_key_self_link       = instance_encryption_key.value.kms_key_self_link
      kms_key_service_account = instance_encryption_key.value.kms_key_service_account
    }
  }

  dynamic "network_interface" {
    for_each = each.value.network_interface != null ? each.value.network_interface : []
    content {
      dynamic "access_config" {
        for_each = network_interface.value.access_config != null ? network_interface.value.access_config : []
        content {
          nat_ip                 = access_config.value.nat_ip
          network_tier           = access_config.value.network_tier
          public_ptr_domain_name = access_config.value.public_ptr_domain_name
        }
      }
      dynamic "alias_ip_range" {
        for_each = network_interface.value.alias_ip_range != null ? network_interface.value.alias_ip_range : []
        content {
          ip_cidr_range         = alias_ip_range.value.ip_cidr_range
          subnetwork_range_name = alias_ip_range.value.subnetwork_range_name
        }
      }
      enable_vpc_scoped_dns       = network_interface.value.enable_vpc_scoped_dns
      igmp_query                  = network_interface.value.igmp_query
      internal_ipv6_prefix_length = network_interface.value.internal_ipv6_prefix_length
      dynamic "ipv6_access_config" {
        for_each = network_interface.value.ipv6_access_config != null ? network_interface.value.ipv6_access_config : []
        content {
          external_ipv6               = ipv6_access_config.value.external_ipv6
          external_ipv6_prefix_length = ipv6_access_config.value.external_ipv6_prefix_length
          name                        = ipv6_access_config.value.name
          network_tier                = ipv6_access_config.value.network_tier
          public_ptr_domain_name      = ipv6_access_config.value.public_ptr_domain_name
        }
      }
      ipv6_address       = network_interface.value.ipv6_address
      network            = network_interface.value.network
      network_attachment = network_interface.value.network_attachment
      network_ip         = network_interface.value.network_ip
      nic_type           = network_interface.value.nic_type
      queue_count        = network_interface.value.queue_count
      stack_type         = network_interface.value.stack_type
      subnetwork         = network_interface.value.subnetwork
      subnetwork_project = network_interface.value.subnetwork_project
      vlan               = network_interface.value.vlan
    }
  }

  dynamic "network_performance_config" {
    for_each = each.value.network_performance_config != null ? [each.value.network_performance_config] : []
    content {
      total_egress_bandwidth_tier = network_performance_config.value.total_egress_bandwidth_tier
    }
  }

  dynamic "params" {
    for_each = each.value.params != null ? [each.value.params] : []
    content {
      resource_manager_tags = params.value.resource_manager_tags
    }
  }

  dynamic "reservation_affinity" {
    for_each = each.value.reservation_affinity != null ? [each.value.reservation_affinity] : []
    content {
      dynamic "specific_reservation" {
        for_each = reservation_affinity.value.specific_reservation != null ? [reservation_affinity.value.specific_reservation] : []
        content {
          key    = specific_reservation.value.key
          values = specific_reservation.value.values
        }
      }
      type = reservation_affinity.value.type
    }
  }

  dynamic "scheduling" {
    for_each = each.value.scheduling != null ? [each.value.scheduling] : []
    content {
      automatic_restart           = scheduling.value.automatic_restart
      availability_domain         = scheduling.value.availability_domain
      host_error_timeout_seconds  = scheduling.value.host_error_timeout_seconds
      instance_termination_action = scheduling.value.instance_termination_action
      dynamic "local_ssd_recovery_timeout" {
        for_each = scheduling.value.local_ssd_recovery_timeout != null ? [scheduling.value.local_ssd_recovery_timeout] : []
        content {
          nanos   = local_ssd_recovery_timeout.value.nanos
          seconds = local_ssd_recovery_timeout.value.seconds
        }
      }
      dynamic "max_run_duration" {
        for_each = scheduling.value.max_run_duration != null ? [scheduling.value.max_run_duration] : []
        content {
          nanos   = max_run_duration.value.nanos
          seconds = max_run_duration.value.seconds
        }
      }
      min_node_cpus = scheduling.value.min_node_cpus
      dynamic "node_affinities" {
        for_each = scheduling.value.node_affinities != null ? scheduling.value.node_affinities : []
        content {
          key      = node_affinities.value.key
          operator = node_affinities.value.operator
          values   = node_affinities.value.values
        }
      }
      on_host_maintenance = scheduling.value.on_host_maintenance
      dynamic "on_instance_stop_action" {
        for_each = scheduling.value.on_instance_stop_action != null ? [scheduling.value.on_instance_stop_action] : []
        content {
          discard_local_ssd = on_instance_stop_action.value.discard_local_ssd
        }
      }
      preemptible        = scheduling.value.preemptible
      provisioning_model = scheduling.value.provisioning_model
      termination_time   = scheduling.value.termination_time
    }
  }

  dynamic "scratch_disk" {
    for_each = each.value.scratch_disk != null ? each.value.scratch_disk : []
    content {
      device_name = scratch_disk.value.device_name
      interface   = scratch_disk.value.interface
      size        = scratch_disk.value.size
    }
  }

  dynamic "service_account" {
    for_each = each.value.service_account != null ? [each.value.service_account] : []
    content {
      email  = service_account.value.email
      scopes = service_account.value.scopes
    }
  }

  dynamic "shielded_instance_config" {
    for_each = each.value.shielded_instance_config != null ? [each.value.shielded_instance_config] : []
    content {
      enable_integrity_monitoring = shielded_instance_config.value.enable_integrity_monitoring
      enable_secure_boot          = shielded_instance_config.value.enable_secure_boot
      enable_vtpm                 = shielded_instance_config.value.enable_vtpm
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "workload_identity_config" {
    for_each = each.value.workload_identity_config != null ? [each.value.workload_identity_config] : []
    content {
      identity                     = workload_identity_config.value.identity
      identity_certificate_enabled = workload_identity_config.value.identity_certificate_enabled
    }
  }
}

