#vSphere environment
common_vcenter_server       = "vcsa.mydomain.co.uk"
common_vcenter_insecure     = true
common_vcenter_datacenter   = "Home Datacenter"
common_vcenter_cluster      = "Primary Cluster"
common_vcenter_datastore    = "datastore-tier1"
common_vcenter_folder       = "Dev/Packer Builds"
common_vcenter_library      = "Primary Library"
common_vcenter_destroy      = true
common_vcenter_ovf          = true
#Boot/provision
common_http_directory = "boot_config"
common_http_port_min  = 8000
common_http_port_max  = 8099
#Build credentials
common_build_username = "packer"
common_build_password = "packer"