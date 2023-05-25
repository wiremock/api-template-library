---
slug: "opto22-com-pac"
title: "PAC Control REST API"
provider: "opto22.com"
description: "#### Revised: 6/15/2018\n\n### Overview\nThis API provides secure access\
  \ to a SNAP-PAC-R or -S series controller's variable and I/O tags. Confidentiality\
  \ for API transactions is provided by HTTPS. Authentication uses HTTP Basic Authentication\
  \ with an API key. An API key ID is submitted in the Basic Authentication userid\
  \ field and API key value in the password field.\n\n**For more information visit:**\
  \ [developer.opto22.com](http://developer.opto22.com)\n\n### Examples\n\n**Read\
  \ an array** of all the integer32 variables defined in the PAC's strategy.\nFor\
  \ example, on your SNAP-PAC-R or -S series controller at IP address 1.2.3.4, you\
  \ would use the URL: \n\n```\nhttps://1.2.3.4/api/v1/device/strategy/vars/int32s\n\
  ```\nand provide appropriate authentication. The GET response will be a JSON array\
  \ of name-value \npairs such as: \n```json\n[ { \"nMyVeryFavoriteNumber\": 22 },\n\
  \  { \"nWidgetsProducedToday\": 22222 },\n  { \"DELAY_LOOP_TIME_IN_MSECS\"  : 200\
  \ } ]\n```\n**Read the engineering units** (EU) of an analog input point configured\
  \ in the PAC's strategy.\nFor an analog input (I/O point) named aiTemperatureInDegreesF,\
  \ use \n\n`https://1.2.3.4/api/v1/device/strategy/ios/analogInputs/aiTemperatureInDegreesF/eu`\n\
  \nThe GET response will be a single JSON name-value pair such as:\n```json\n{ \"\
  value\": 72.22 }\n```    \n\n### Note on packet sizes:\nWhen doing POSTs or GETs,\
  \ the JSON payload in the body should not exceed 3k (3072 bytes).\n"
logo: "opto22.com-pac-logo.jpeg"
logoMediaType: "image/jpeg"
tags:
- "iot"
stubs: "opto22.com-pac-stubs.json"
swagger: "opto22.com-pac-swagger.json"
---
