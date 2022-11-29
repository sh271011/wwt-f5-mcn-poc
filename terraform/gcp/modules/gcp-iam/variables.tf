variable "role_id" {
    default = "volterraDeploy"
    type = string
    description = "Role ID for newly created deployment role. Camel case suggested, cannot contain - characters."
    validation {
        condition = !can(regex("-", var.role_id))
        error_message = "Namespaces cannot include _ characters."
    }
}

variable "sa_create_timeout" {
  type = string
  default = "5s"
}

variable "role_title" {
    type = string
    description = "Title for the newly created deployment role."
}