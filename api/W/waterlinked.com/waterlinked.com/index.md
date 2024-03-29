---
slug: "waterlinked-com"
title: "The Water Linked Underwater GPS API"
provider: "waterlinked.com"
description: "API for the Water Linked Underwater GPS. For more details: http://www.waterlinked.com\n\
  \nRecommended approach for connecting to a Underwater GPS via the API is:\n- If\
  \ \"GET /api/\" times out, the Underwater GPS is not running (on this IP address)\n\
  - If \"GET /api/\" responds with 200 OK check that the api version returrned (eg\
  \ \"v1\") is supported by the client (eg: also supports \"v1\").\n- If the api version\
  \ returned does not match what the client supports: give an error to the user and\
  \ recommend upgrading. (Eg: response is \"v2\" while client only supports \"v1\"\
  )\n- If \"GET /api/\" responds with 301 Moved permanently. \"GET /api/v1/version\"\
  \ to check if the kit has a version earlier than 1.5.\n- \"GET /api/v1/version\"\
  \ will always respond with 200 OK on Underwater GPS earlier than 1.5 release.\n\n\
  Configuration API is is not considered stable and will potentially be changed"
logo: "waterlinked.com-logo.jpeg"
logoMediaType: "image/jpeg"
tags:
- "location"
stubs: "waterlinked.com-stubs.json"
swagger: "waterlinked.com-swagger.json"
---
