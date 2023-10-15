variable "app_name" {
  default = "my-app"
}

variable "rg_location" {
  default = "West Europe"
}

variable "web_github_pat" {
  default = ""
}

variable "cloudflare_zone_id" {
  default = ""
}

variable "acs_data_location" {
  description = "The location of the Azure Communication Service."
  default = "United States"
}