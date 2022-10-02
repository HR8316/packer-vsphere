source "vsphere-iso" "rhel-9_0" {
  
  #vSphere environment
  username            = var.common_vcenter_username
  password            = var.common_vcenter_password
  vcenter_server      = var.common_vcenter_server
  insecure_connection = var.common_vcenter_insecure
  datacenter          = var.common_vcenter_datacenter
  cluster             = var.common_vcenter_cluster
  datastore           = var.common_vcenter_datastore
  folder              = var.common_vcenter_folder
  content_library_destination {
    name              = "rhel-9_0-{{ isotime \"02-01-2006\" }}" 
    library           = var.common_vcenter_library
    destroy           = var.common_vcenter_destroy
    ovf               = var.common_vcenter_ovf
  }
  #Removable media
  iso_url         = "https://access.cdn.redhat.com/content/origin/files/sha256/f3/f3ca9b53122212ed98866ef60e4895cc762493ced765e2961458944ba7c0ced3/rhel-baseos-9.0-x86_64-boot.iso?user=03103a3f50d4c8acbe940c22612b0867&_auth_=1664665766_f41e4fa7a8bbd24682a24ac7d6e72a1a"
  iso_checksum    = "sha256:f3ca9b53122212ed98866ef60e4895cc762493ced765e2961458944ba7c0ced3"
  #Guest operating system
  vm_name = "rhel-9.0" 
  guest_os_type = "rhel9_64Guest"
  #Virtual machine hardware
  CPUs         = 2
  CPU_hot_plug = true
  RAM          = 4096
  RAM_hot_plug = true
  storage {
    disk_size             = 61440
    disk_thin_provisioned = true
  }
  disk_controller_type = ["pvscsi"]
  network_adapters {
    network      = "Services"
    network_card = "vmxnet3"
  }
  cdrom_type   = "sata"
  remove_cdrom = true
  firmware     = "efi-secure"
  #Boot/provision
  ssh_username   = var.common_build_username
  ssh_password   = var.common_build_password
  http_directory = var.common_http_directory
  http_port_min  = var.common_http_port_min
  http_port_max  = var.common_http_port_max
  boot_command   = ["<up>",
                    "e",
                    "<down><down><end><wait>",
                    "inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rhel-9_0/kickstart.cfg",
                    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
}

build {
  sources = [
    "source.vsphere-iso.rhel-9_0",
  ]
}