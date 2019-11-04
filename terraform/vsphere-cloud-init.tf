#===============================================================================
# vSphere Provider
#===============================================================================

provider "vsphere" {
  version        = "1.13.0"
  vsphere_server = "${var.vsphere_vcenter}"
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"

  allow_unverified_ssl = "${var.vsphere_unverified_ssl}"
}

#===============================================================================
# vSphere Data
#===============================================================================

data "vsphere_datacenter" "dc" {
  name = "${var.vsphere_datacenter}"
}

data "vsphere_compute_cluster" "cluster" {
  name          = "${var.vsphere_cluster}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "datastore" {
  name          = "${var.vm_datastore}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "${var.vm_network}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vm_template}"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

#===============================================================================
# vSphere Resources
#===============================================================================

resource "vsphere_virtual_machine" "vm" {
  count = "${var.vm_count}"
  name             = "${var.vm_name_prefix}-${format("%02d", count.index + 1)}"
  resource_pool_id = "${data.vsphere_compute_cluster.cluster.resource_pool_id}"
  datastore_id     = "${data.vsphere_datastore.datastore.id}"

  num_cpus = "${var.vm_cpu}"
  memory   = "${var.vm_ram}"
  guest_id = "${data.vsphere_virtual_machine.template.guest_id}"

  scsi_type = "${data.vsphere_virtual_machine.template.scsi_type}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label             = "disk0.vmdk"
    size             = "${data.vsphere_virtual_machine.template.disks.0.size}"
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
    linked_clone = "${var.vm_linked_clone}"
  }

  cdrom {
    client_device = true
  }

  vapp {
    properties = {
        "instance-id" = "terraform-${count.index}",
        "hostname" = "${var.vm_name_prefix}-${format("%02d", count.index + 1)}",
        "public-keys" = "${var.vm_default_user_public_key}",
        "user-data" = "${base64encode(templatefile("user-data.yml", { 
          ip_addr = cidrhost(var.vm_ip_range, count.index),
          ip_netmask = var.vm_netmask,
          ip_gateway = var.vm_gateway,
          dns_servers = var.vm_dns
        }))}",
        "password" = "${var.vm_default_user_password}",
    }
  }
}