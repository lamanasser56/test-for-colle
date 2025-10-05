variable "db_admin_username" {
  description = "Database admin username"
  type        = string
  sensitive   = true
  default     = "sqladmin_lama"
}

variable "db_admin_password" {
  description = "Database admin password"
  type        = string
  sensitive   = true
}

