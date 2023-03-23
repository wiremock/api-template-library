---
slug: "adyen-com-PaymentService"
name: "Adyen Payment API"
provider: "adyen.com"
description: "A set of API endpoints that allow you to initiate, settle, and modify\
  \ payments on the Adyen payments platform. You can use the API to accept card payments\
  \ (including One-Click and 3D Secure), bank transfers, ewallets, and many other\
  \ payment methods.\n\nTo learn more about the API, visit [Classic integration](https://docs.adyen.com/classic-integration).\n\
  \n## Authentication\nYou need an [API credential](https://docs.adyen.com/development-resources/api-credentials)\
  \ to authenticate to the API.\n\nIf using an API key, add an `X-API-Key` header\
  \ with the API key as the value, for example:\n\n ```\ncurl\n-H \"Content-Type:\
  \ application/json\" \\\n-H \"X-API-Key: YOUR_API_KEY\" \\\n...\n```\n\nAlternatively,\
  \ you can use the username and password to connect to the API using basic authentication,\
  \ for example:\n\n```\ncurl\n-U \"ws@Company.YOUR_COMPANY_ACCOUNT\":\"YOUR_BASIC_AUTHENTICATION_PASSWORD\"\
  \ \\\n-H \"Content-Type: application/json\" \\\n...\n```\n\n## Versioning\nPayments\
  \ API supports [versioning](https://docs.adyen.com/development-resources/versioning)\
  \ using a version suffix in the endpoint URL. This suffix has the following format:\
  \ \"vXX\", where XX is the version number.\n\nFor example:\n```\nhttps://pal-test.adyen.com/pal/servlet/Payment/v68/authorise\n\
  ```\n\n## Going live\n\nTo authenticate to the live endpoints, you need an [API\
  \ credential](https://docs.adyen.com/development-resources/api-credentials) from\
  \ your live Customer Area.\n\nThe live endpoint URLs contain a prefix which is unique\
  \ to your company account:\n```\n\nhttps://{PREFIX}-pal-live.adyenpayments.com/pal/servlet/Payment/v68/authorise\n\
  ```\n\nGet your `{PREFIX}` from your live Customer Area under **Developers** > **API\
  \ URLs** > **Prefix**."
logo: "adyen.com-PaymentService-logo.svg"
logoMediaType: "image/svg+xml"
tags:
- name: "payment"
stubs: "adyen.com-PaymentService-stubs.json"
---
