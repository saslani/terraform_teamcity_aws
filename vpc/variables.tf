variable "availability_zones" {
  description = "List of availability zones over which to distribute subnets"
  type        = list(string)
}

variable "length" {
  default = 1
}

variable "public_cidr_block" {
  default = "10.0.0.0/24"
}

variable "private_cidr_block" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

