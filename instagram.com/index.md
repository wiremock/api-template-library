---
slug: "instagram-com"
name: "Instagram API"
provider: "instagram.com"
description: "Description of Instagram RESTful API.\n\nCurrent limitations:\n  * Instagram\
  \ service does not support [cross origin headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS)\n\
  \  for security reasons, therefore it is not possible to use Swagger UI and make\
  \ API calls directly from browser.\n  * Modification API requests (`POST`, `DELETE`)\
  \ require additional security [scopes](https://instagram.com/developer/authorization/)\n\
  \  that are available for Apps [created on or after Nov 17, 2015](http://instagram.com/developer/review/)\
  \ and\n  started in [Sandbox Mode](http://instagram.com/developer/sandbox/).\n \
  \ * Consider the [Instagram limitations](https://instagram.com/developer/limits/)\
  \ for API calls that depends on App Mode.\n\n**Warning:** For Apps [created on or\
  \ after Nov 17, 2015](http://instagram.com/developer/changelog/) API responses\n\
  containing media objects no longer return the `data` field in `comments` and `likes`\
  \ nodes.\n\nLast update: 2015-11-28\n"
logo: "instagram.com-logo.png"
logoMediaType: "image/png"
tags:
- name: "social"
- name: "media"
stubs: "instagram.com-stubs.json"
---
