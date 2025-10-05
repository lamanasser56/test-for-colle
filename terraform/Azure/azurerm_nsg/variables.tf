
variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "gateway_subnet_id" {
  type = string
}

variable "webapp_subnet_id" {
  type = string
}

variable "database_subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}