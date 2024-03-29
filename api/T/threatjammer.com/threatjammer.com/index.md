---
slug: "threatjammer-com"
title: "ThreatJammer.com User API"
provider: "threatjammer.com"
description: "\nThe public API open to the users. [Read the docs and learn more.](https://threatjammer.com/docs).\n\
  \n## General information\n\n### Description\nThreat Jammer supports two end-user\
  \ REST APIs: the User API and the Report API. The end-user uses the User API to\
  \ interact with the different databases, heuristics, and machine learning processes.\
  \ Devices use the Report API to interact with Threat Jammer. This document will\
  \ explain how to use the User API and interact with the different services, create\
  \ a token, interpret the quota information, and create the HTTP request to interact\
  \ with the User API.\n\n### Authentication\nThe API is protected by a **Bearer authentication**\
  \ schema. **Bearer authentication** (also called **token authentication**) is an\
  \ HTTP authentication scheme that involves security tokens called bearer tokens.\
  \ It is used to authenticate the user. All the different endpoints expect a `Bearer`\
  \ token in the `Authorization` header.\n\nExample:\n\n```\ncurl -X 'GET'\n  'https://dublin.api.threatjammer.com/test'\n\
  \  -H 'accept: application/json'\n  -H 'Authorization: Bearer YOUR_API_KEY'\n```\n\
  \nYou can obtain a token after registering on the [ThreatJammer.com](https://threatjammer.com)\
  \ website for free.\n\n\n### Region specific tokens\nAll the `Bearer` tokens contain\
  \ information about the authorized region. The developers have to use a token created\
  \ for the region they want to use. A token used in a different region will return\
  \ a `401 Unauthorized` error.\n\n### Global errors\n\nThe API will return the following\
  \ permanent errors:\n- a `401 Unauthorized` error if the token is not valid, or\
  \ does not belong to the region.\n- a `401 Unauthorized` error if the token does\
  \ not exist.\n- a `401 Unauthorized` error if the token is malformed.\n- a `403\
  \ Forbidden` error if the subscription level is not enough. Some endpoints are only\
  \ available for paid subscription levels.\n\nAnd these temporary errors:\n- a `429\
  \ Too Many Requests` error if the quota is exceeded (see below).\n\n### Quota limits\n\
  \n**Every request to the User API will consume one (1) quota point.**\n\nThe API\
  \ has two rate limiting processes:\n- a quota limit of **5000** requests per month\
  \ for the `FREE` account. The limit is reset every month.\n- a quota limit of **10**\
  \ requests per minute for the `FREE` account. The limit is reset every minute and\
  \ implements a sliding window mechanism.\n\n"
logo: "threatjammer.com-logo.png"
logoMediaType: "image/png"
tags: []
stubs: "threatjammer.com-stubs.json"
swagger: "threatjammer.com-swagger.json"
---
