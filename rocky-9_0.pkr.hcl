source "vsphere-iso" "rocky-9_0" {
  
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
    name              = "rocky-9.0-base-{{ isotime \"02-01-2006\" }}" 
    library           = var.common_vcenter_library
    destroy           = var.common_vcenter_destroy
    ovf               = var.common_vcenter_ovf
  }
  #Removable media
  iso_url         = "https://download.rockylinux.org/pub/rocky/9/isos/x86_64/Rocky-9.0-20220805.0-x86_64-minimal.iso"
  iso_checksum    = "b16bc85f4fd14facf3174cd0cf8434ee048d81e5470292f3e1cfff47af2463b7"
  #Guest operating system
  vm_name = "rocky-9.0" 
  guest_os_type = "centos9_64Guest"
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
                    "inst.text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/rocky-9_0/kickstart.cfg",
                    "<enter><wait><leftCtrlOn>x<leftCtrlOff>"
  ]
}

build {
  sources = [
    "source.vsphere-iso.rocky-9_0",
  ]
}