---
slug: "cisco-com"
title: "Cisco PSIRT openVuln API"
provider: "cisco.com"
description: "The Cisco Product Security Incident Response Team (PSIRT) openVuln API\
  \ is a RESTful API that allows customers to obtain Cisco Security Vulnerability\
  \ information in different machine-consumable formats. APIs are important for customers\
  \ because they allow their technical staff and programmers to build tools that help\
  \ them do their job more effectively (in this case, to keep up with security vulnerability\
  \ information).\nFor more information about the Cisco PSIRT openVuln API visit https://developer.cisco.com/site/PSIRT/discover/overview\n\
  \nFor detail steps on how to use the API go to:https://developer.cisco.com/site/PSIRT/get-started/getting-started.gsp\n\
  \nThis is a beta release of a swagger YAML for the Cisco PSIRT openVuln API\n\n\
  To access the API sign in with your Cisco CCO account at http://apiconsole.cisco.com\
  \ and register an application\nto recieve a client_id and a client_secret\n\nYou\
  \ can then get your token using curl or any other method you prefer.\n\n'curl -s\
  \ -k -H \"Content-Type: application/x-www-form-urlencoded\" -X POST -d \"client_id=<your_client_id>\"\
  \ -d \"client_secret=<your_client_secret>\" -d \"grant_type=client_credentials\"\
  \ https://cloudsso.cisco.com/as/token.oauth2'\n\nYou will receive an access token\
  \ as demonstrated in the following example:\n '{\"access_token\":\"I7omWtBDAieSiUX3shOxNJfuy4J6\"\
  ,\"token_type\":\"Bearer\",\"expires_in\":3599}'\n\nIn Swagger, click on Change\
  \ Authentication\n\nenter the text \"I7omWtBDAieSiUX3shOxNJfuy4J6\" (which is the\
  \ token you received)\n\nthen click on \"Try this operation\"\n"
logo: "cisco.com-logo.svg"
logoMediaType: "image/svg+xml"
tags:
- "security"
stubs: "cisco.com-stubs.json"
swagger: "cisco.com-swagger.json"
---
