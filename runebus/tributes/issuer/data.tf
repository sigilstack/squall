locals {
  tribute_index = jsondecode(data.http.tribute_index.response_body).tribute_requests
  # make it easier to work with the tribute index url by removing the trailing slash
  resolved_tribute_index_url = trim(var.tribute_index_url, "/")


  request_headers = {
    "user-agent" = "RuneBus Tribute Issuer"
  }

  all_tributes = {
    for tribute in local.tribute_index :
    tribute.name => {
      json   = jsondecode(data.http.tributes[tribute.name].response_body),
      raw    = data.http.tributes[tribute.name].response_body,
      base64 = base64encode(data.http.tributes[tribute.name].response_body)
    }
  }
}

data "cloudflare_account" "this" {
  filter = {
    name = var.cloudflare_account_name
  }

  lifecycle {
    postcondition {
      condition     = can(self.account_id)
      error_message = "Cloudflare account '${var.cloudflare_account_name}' not found."
    }
  }
}

data "http" "tribute_index" {
  url             = format("%s/index.json", local.resolved_tribute_index_url)
  request_headers = local.request_headers

  lifecycle {
    postcondition {
      condition     = can(jsondecode(self.response_body).tribute_requests)
      error_message = "The tribute index does not contain a valid 'tribute_requests' field. ${self.response_body}"
    }

    postcondition {
      condition     = contains([200, 201, 204], self.status_code)
      error_message = "Failed to fetch tribute index: HTTP status code ${self.status_code}."
    }
  }
}

data "http" "tributes" {
  for_each        = { for tribute in local.tribute_index : tribute.name => tribute.path }
  url             = format("%s/%s", var.tribute_index_url, each.value)
  request_headers = local.request_headers
}
