# runebus

The runebus is a reference implementation of the SQUALL protocol, designed to demonstrate the core principles and features of the system. It serves as a practical example for developers looking to understand how to implement SQUALL in their own applications.

## Features

### Tribute System

Per the SQUALL RFC, the runebus implements a tribute system that allows users to pay homage to IANA (see [RFC-0001](../rfc/RFC-0001-parallel-universe.md)). Only a central
managing body need implement the tribute system; but squall is designed to be extensible as to maintain compatibility regardless which parallel universe it finds itself in.

#### Files

`./tribute/` contains the tribute system implementation, including the tribute manager and tribute handlers.
