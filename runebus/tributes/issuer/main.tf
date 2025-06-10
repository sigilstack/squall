data "cloudflare_zone" "squall" {
  filter = {
    name = var.squall_root
  }

  lifecycle {
    postcondition {
      condition     = can(self.id)
      error_message = "Squall zone not found or not accessible. Please check the zone name and account ID."
    }
  }
}

# create delegated subdomains for tributes.<cloudflare_zone>
# resource "cloudflare_zone" "tributes" {
#   name = "tributes.${var.squall_root}"
#   account = {
#     id = data.cloudflare_account.this.account_id
#   }
# }

# create the NS delegation for the tributes subdomain
# resource "cloudflare_dns_record" "tribute_ns_delegation" {
#   zone_id = data.cloudflare_zone.squall.zone_id
#   name    = "tributes"
#   type    = "NS"
#   ttl     = 600
#   content = join(",", [for ns in cloudflare_zone.tributes.name_servers : ns])

#   comment = "NS delegation for tributes subdomain"
#   tags = [
#     "source:issuer",
#     "tribute:delegation"
#   ]
# }

# create the delegated subdomain for iana.<cloudflare_zone>
# resource "cloudflare_zone" "iana" {
#   name = "iana.${var.squall_root}"
#   account = {
#     id = data.cloudflare_account.this.account_id
#   }
# }

# create the NS delegation for the iana subdomain
# resource "cloudflare_dns_record" "iana_ns_delegation" {
#   zone_id = data.cloudflare_zone.squall.zone_id
#   name    = "iana"
#   type    = "NS"
#   ttl     = 3600
#   content = join(",", [for ns in cloudflare_zone.iana.name_servers : ns])

#   comment = "NS delegation for iana subdomain"
#   tags = [
#     "source:issuer",
#     "iana:delegation"
#   ]
# }

# Create TXT records for issued tributes in the IANA subdomain
resource "cloudflare_dns_record" "requested_tributes" {
  for_each = toset(keys(local.all_tributes))

  zone_id = data.cloudflare_zone.squall.zone_id
  name    = format("%s.issued.iana.squall.zone", each.key)
  type    = "TXT"
  ttl     = 300
  proxied = false

  comment = "Issued tribute record for ${each.key}"
  content = format("b64: %s", local.all_tributes[each.key].base64)
  # tags = [
  #   "source:issuer",
  #   "tribute:${each.key}",
  # ]
}
