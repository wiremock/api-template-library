---
slug: "asuarez-dev-searchly"
name: "SearchLy API v1"
provider: "asuarez.dev"
description: "# Introduction\nThe SearchLy API provides similarity searching based\
  \ on song lyrics.\n\n# Operations\nThe API allows for the `/similarity/by_song`\
  \ operation, which allows clients to search the similarity for an existing song\
  \ in the database. Also, the API has an additional `/similarity/by_content` endpoint\
  \ which allows clients to search similarity given a free String input through a\
  \ JSON request body. Additional `/song/search` operation is available for searching\
  \ songs given a query String.\n\n# Endpoint\nThe API endpoint for the SearchLy API\
  \ v1 is as follows:\n```\nhttps://searchly.asuarez.dev/api/v1\n```\n\n# Motivation\n\
  This project was built in order to create an API for searching similarities based\
  \ on song lyrics. There are a lot of songs in the industry and most of them are\
  \ talking about the same topic. What I wanted to prove with SearchLy was to estimate\
  \ how similar are two songs between them based on the meaning of their lyrics.\n\
  \nSearchLy is using a database of 100k songs from AZLyrics, using [this scraper](https://github.com/AlbertSuarez/azlyrics-scraper),\
  \ which is being updated periodically. Then, using word2vec and NMSLIB, it was possible\
  \ to create an index where you can search similarities using the k-nearest neighbors\
  \ (KNN) algorithm.\n\n> **Note**: I am currently using a micro-instance from DigitalOcean\
  \ where the API is deployed, so you should expect a bad performance. However, if\
  \ this API becomes popular I will deploy it in a bigger instance.\n"
logo: "asuarez.dev-searchly-logo.svg"
logoMediaType: "image/svg+xml"
tags:
- name: "media"
stubs: "asuarez.dev-searchly-stubs.json"
---
