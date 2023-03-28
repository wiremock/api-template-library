---
slug: "adyen-com-CheckoutUtilityService"
title: "Adyen Checkout Utility Service"
provider: "adyen.com"
description: "A web service containing utility functions available for merchants integrating\
  \ with Checkout APIs.\n## Authentication\nEach request to the Checkout Utility API\
  \ must be signed with an API key. For this, obtain an API Key from your Customer\
  \ Area, as described in [How to get the Checkout API key](https://docs.adyen.com/developers/user-management/how-to-get-the-checkout-api-key).\
  \ Then set this key to the `X-API-Key` header value, for example:\n\n```\ncurl\n\
  -H \"Content-Type: application/json\" \\\n-H \"X-API-Key: Your_Checkout_API_key\"\
  \ \\\n...\n```\nNote that when going live, you need to generate a new API Key to\
  \ access the [live endpoints](https://docs.adyen.com/developers/api-reference/live-endpoints).\n\
  \n## Versioning\nCheckout API supports versioning of its endpoints through a version\
  \ suffix in the endpoint URL. This suffix has the following format: \"vXX\", where\
  \ XX is the version number.\n\nFor example:\n```\nhttps://checkout-test.adyen.com/v1/originKeys\n\
  ```"
logo: "adyen.com-CheckoutUtilityService-logo.jpeg"
logoMediaType: "image/jpeg"
tags:
- "payment"
stubs: "adyen.com-CheckoutUtilityService-stubs.json"
swagger: "adyen.com-CheckoutUtilityService-swagger.json"
---
