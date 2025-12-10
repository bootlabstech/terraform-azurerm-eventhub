variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "namespace_sku" {
  type        = string
  description = "SKU for Event Hub namespace"
  default     = "Standard"
}

variable "namespace_capacity" {
  type        = number
  description = "Capacity for Event Hub namespace"
  default     = 1
}

variable "name" {
  type        = string
  description = "Name of the Event Hub"
}

variable "partition_count" {
  type        = number
  description = "Partition count for Event Hub"
  default     = 2
}

variable "message_retention" {
  type        = number
  description = "Message retention in days"
  default     = 1
}

variable "auth_rule_name" {
  type        = string
  description = "Authorization rule name"
  default     = "send-listen-rule"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Resource tags"
  default     = false
}

variable "subnet_id" {
  type = string
  description = "subnet id"
}
variable "private_dns_zone_ids" {
  type = list(string)
  description = "pvt dns zone ids"
}

variable "listen" {
  type        = bool
  default     = true
  description = "Whether to enable listen permission on the Event Hub authorization rule."
}

variable "send" {
  type        = bool
  default     = true
  description = "Whether to enable send permission on the Event Hub authorization rule."
}

variable "manage" {
  type        = bool
  default     = false
  description = "Whether to enable manage permission on the Event Hub authorization rule."
}