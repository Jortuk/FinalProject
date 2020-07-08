variable "pem_keyname" {
  description = "Name of SSH Key."
  type        = string
}

variable "pem_keypub" {
  description = "Public Key associated."
  type        = string
}

variable "username" {
  description = "Please Enter the Username assosiated with the Database."
  type        = string
}

variable "password" {
  description = "Database Password."
  type        = string
}