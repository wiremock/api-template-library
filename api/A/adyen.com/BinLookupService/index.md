---
slug: "adyen-com-BinLookupService"
title: "Adyen BinLookup API"
provider: "adyen.com"
description: "The BIN Lookup API provides endpoints for retrieving information, such\
  \ as cost estimates, and 3D Secure supported version based on a given BIN.\n\n##\
  \ Authentication\nYou need an [API credential](https://docs.adyen.com/development-resources/api-credentials)\
  \ to authenticate to the API.\n\nIf using an API key, add an `X-API-Key` header\
  \ with the API key as the value, for example:\n\n ```\ncurl\n-H \"Content-Type:\
  \ application/json\" \\\n-H \"X-API-Key: YOUR_API_KEY\" \\\n...\n```\n\nAlternatively,\
  \ you can use the username and password to connect to the API using basic authentication,\
  \ for example:\n\n```\ncurl\n-U \"ws@Company.YOUR_COMPANY_ACCOUNT\":\"YOUR_BASIC_AUTHENTICATION_PASSWORD\"\
  \ \\\n-H \"Content-Type: application/json\" \\\n...\n```\n\n## Versioning\nThe BinLookup\
  \ API supports [versioning](https://docs.adyen.com/development-resources/versioning)\
  \ using a version suffix in the endpoint URL. This suffix has the following format:\
  \ \"vXX\", where XX is the version number.\n\nFor example:\n```\nhttps://pal-test.adyen.com/pal/servlet/BinLookup/v54/get3dsAvailability\n\
  ```## Going live\n\nTo authneticate to the live endpoints, you need an [API credential](https://docs.adyen.com/development-resources/api-credentials)\
  \ from your live Customer Area.\n\nThe live endpoint URLs contain a prefix which\
  \ is unique to your company account:\n```\n\nhttps://{PREFIX}-pal-live.adyenpayments.com/pal/servlet/BinLookup/v54/get3dsAvailability\n\
  ```\n\nGet your `{PREFIX}` from your live Customer Area under **Developers** > **API\
  \ URLs** > **Prefix**."
logo: "adyen.com-BinLookupService-logo.svg"
logoMediaType: "image/svg+xml"
tags:
- "payment"
stubs: "adyen.com-BinLookupService-stubs.json"
swagger: "adyen.com-BinLookupService-swagger.json"
---
