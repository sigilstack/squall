# Tribute Issuer

## inputs
- squall_tld: The top-level domain for the SQUALL protocol, which is used to identify the tribute system.
- tributes: A list of tribute objects, each containing the following fields:
  - `name`: The name of the tribute.
  - `description`: A description of the tribute.
  - `ns`: The DNS records
  - `icon`: An optional icon for the tribute.

## outputs
- tribute_id: A unique identifier for the tribute request.
- status: The status of the tribute request, which can be one of the following:
  - `pending`: The tribute request has been issued and is awaiting validation.
  - `validated`: The tribute request has been validated and the delegation NS records have been provisioned.
  - `rescinded`: The tribute request has been rescinded due to failure to validate.

## resources created
- txt_record: A TXT record in the SQUALL TLD containing the tribute request information.
