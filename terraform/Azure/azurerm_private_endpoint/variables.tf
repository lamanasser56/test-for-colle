variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}
variable "sql_server_id" {
  type = string
}

variable "private_dns_zone_id" {
  type = string
}

variable "tags" {
  type = map(string)
}