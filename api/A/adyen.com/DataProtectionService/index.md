---
slug: "adyen-com-DataProtectionService"
title: "Adyen Data Protection API"
provider: "adyen.com"
description: "Adyen Data Protection API provides a way for you to process [Subject\
  \ Erasure Requests](https://gdpr-info.eu/art-17-gdpr/) as mandated in GDPR.\n\n\
  Use our API to submit a request to delete shopper's data, including payment details\
  \ and other related information (for example, delivery address or shopper email).##\
  \ Authentication\nEach request to the Data Protection API must be signed with an\
  \ API key. Get your API Key from your Customer Area, as described in [How to get\
  \ the API key](https://docs.adyen.com/development-resources/api-credentials#generate-api-key).\
  \ Then set this key to the `X-API-Key` header value, for example:\n\n```\ncurl\n\
  -H \"Content-Type: application/json\" \\\n-H \"X-API-Key: Your_API_key\" \\\n...\n\
  ```\nNote that when going live, you need to generate a new API Key to access the\
  \ [live endpoints](https://docs.adyen.com/development-resources/live-endpoints).\n\
  \n## Versioning\nData Protection Service API supports [versioning](https://docs.adyen.com/development-resources/versioning)\
  \ using a version suffix in the endpoint URL. This suffix has the following format:\
  \ \"vXX\", where XX is the version number.\n\nFor example:\n```\nhttps://ca-test.adyen.com/ca/services/DataProtectionService/v1/requestSubjectErasure\n\
  ```"
logo: "adyen.com-DataProtectionService-logo.svg"
logoMediaType: "image/svg+xml"
tags:
- "payment"
stubs: "adyen.com-DataProtectionService-stubs.json"
swagger: "adyen.com-DataProtectionService-swagger.json"
---
