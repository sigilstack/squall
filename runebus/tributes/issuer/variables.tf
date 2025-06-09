variable "cloudflare_account_name" {
  description = "The name of the Cloudflare account to use"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9._-]+$", var.cloudflare_account_name))
    error_message = "cloudflare_account_name must be a valid account name."
  }
}

variable "squall_root" {
  description = "The root domain for Squall, e.g., 'squall.zone'"
  type        = string

  validation {
    condition     = can(regex("^([a-z0-9]+(-[a-z0-9]+)*\\.)*[a-z]{2,}$", var.squall_root))
    error_message = "squall_root must be a valid domain name."
  }
}

variable "tribute_index_url" {
  description = "Remote URL to fetch tribute index"
  type        = string

  validation {
    condition     = can(regex("^https?://", var.tribute_index_url))
    error_message = "tribute_index_url must be a valid URL"
  }
}
