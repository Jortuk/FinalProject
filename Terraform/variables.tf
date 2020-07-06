variable "pem_keyname" {
  description = "Name of SSH Key."
  type        = string
}

variable "pem_keypub" {
  description = "Public Key associated."
  type        = string
}

variable "username" {
  description = "RDS Username."
  type        = string
}

variable "password" {
  description = "RDS Password."
  type        = string
}