output "tribute_records" {
  description = "Map of tribute names to their issued TXT records in the IANA subdomain"
  value = {
    for tribute in cloudflare_dns_record.requested_tributes :
    tribute.name => {
      name    = tribute.name
      content = tribute.content
    }
  }
}
