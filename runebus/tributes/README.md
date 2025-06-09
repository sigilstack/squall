# tributes

## Purpose

This SigilStack Worker definition implements the Tribute System.

## Components

- Tribute Issuer:
  - allows a tribute request to be issued; it will assign a static tribute ID with validation records
  - manages the tribute validation process storing records of tribute requests and their statuses
- Tribute Handler:
  - once a tribute request has been issued, the tribute handler will start provisioning the delegation NS records in the squall TLD
  - it will run on a sechedule to check for both new requests, and to validate existing tribute requests
  - if a remote tribute delegation has been failing for two weeks, it will remove the delegation NS records and mark the tribute as rescinded
