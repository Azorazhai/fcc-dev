variable "owner" {
  type    = string
  default = "jon velez"
}

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "type" {
  type = map(any)
  default = {
    public      = "tf_public"
    private     = "tf_internal"
    transit     = "tf_transit"
    database    = "tf_db"
    development = "tf_dev"
  }
}

variable "host_os" {
  type = string
  default = "linux"
}