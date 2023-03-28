---
slug: "apicurio-local-registry"
title: "Apicurio Registry API [v2]"
provider: "apicurio.local"
description: "Apicurio Registry is a datastore for standard event schemas and API\
  \ designs. Apicurio Registry enables developers to manage and share the structure\
  \ of their data using a REST interface. For example, client applications can dynamically\
  \ push or pull the latest updates to or from the registry without needing to redeploy.\
  \ Apicurio Registry also enables developers to create rules that govern how registry\
  \ content can evolve over time. For example, this includes rules for content validation\
  \ and version compatibility.\n\nThe Apicurio Registry REST API enables client applications\
  \ to manage the artifacts in the registry. This API provides create, read, update,\
  \ and delete operations for schema and API artifacts, rules, versions, and metadata.\
  \ \n\nThe supported artifact types include:\n- Apache Avro schema\n- AsyncAPI specification\n\
  - Google protocol buffers\n- GraphQL schema\n- JSON Schema\n- Kafka Connect schema\n\
  - OpenAPI specification\n- Web Services Description Language\n- XML Schema Definition\n\
  \n\n**Important**: The Apicurio Registry REST API is available from `https://MY-REGISTRY-URL/apis/registry/v2`\
  \ by default. Therefore you must prefix all API operation paths with `../apis/registry/v2`\
  \ in this case. For example: `../apis/registry/v2/ids/globalIds/{globalId}`.\n"
logo: "apicurio.local-registry-logo.svg"
logoMediaType: "image/svg+xml"
tags:
- "developer_tools"
stubs: "apicurio.local-registry-stubs.json"
swagger: "apicurio.local-registry-swagger.json"
---
