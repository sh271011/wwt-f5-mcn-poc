variable "name" {
    type = string
    description = "Name for new namespace, or queried existing namespace."
    validation {
        condition = !can(regex("_", var.name))
        error_message = "Namespaces cannot include _ characters."
    }
}

variable "namespace_create_timeout" {
  type = string
  default = "5s"
}