provider "ibm" {
  ibmcloud_api_key   = var.ibmcloud_api_key
  generation         = 1
  region             = "us-south"
  iaas_classic_username = var.iaas_classic_username
  iaas_classic_api_key  = var.iaas_classic_api_key
}
resource "ibm_resource_group" "cos_group" {
  name     = "prod"
}

resource "ibm_resource_instance" "cos_instance" {
  name              = "cos-instance"
  resource_group_id = ibm_resource_group.cos_group.id
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
}

resource "ibm_cos_bucket" "standard-ams03" {
  bucket_name          = "1mybucket1"
  resource_instance_id = ibm_resource_instance.cos_instance.id
  region_location      = "us-south"
  storage_class        = "standard"
}

/*
data "ibm_resource_group" "cos_group" {
  name = "cos-resource-group"
}

resource "ibm_resource_instance" "cos_instance" {
  name              = "cos-instance"
  resource_group_id = data.ibm_resource_group.cos_group.id
  service           = "cloud-object-storage"
  plan              = "standard"
  location          = "global"
}

resource "ibm_cos_bucket" "standard-ams03" {
  bucket_name = "a-standard-bucket-at-ams"
  resource_instance_id = ibm_resource_instance.cos_instance.id
  single_site_location = "ams03"
  storage_class = "standard"
}
*/