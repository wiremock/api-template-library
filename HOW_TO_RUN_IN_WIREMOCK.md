# How to run a mock API template in WireMock Open Source

This guide explains how to run an API template after you've downloaded the JSON file from the library page.

## WireMock standalone JAR

Create a folder called `mappings` if one doesn't already exist in the directory containing the standalone JAR file.

Copy the downloaded JSON file into the `mappings` directory then start WireMock via the command line e.g.

```bash
java -jar wiremock-jre8-standalone-2.35.0.jar
```

The JSON will be automatically loaded at startup.

See [https://wiremock.org/docs/standalone/java-jar/](https://wiremock.org/docs/standalone/java-jar/) for general details on running WireMock standalone.

## Docker

Create a folder with a subfolder inside called `mappings`.

Copy the JSON file into the `mappings` folder.

Start the Docker container, mounting the parent folder e.g. assuming the current directory contains `mappings`:

```bash
docker run -it --rm \
  -p 8080:8080 \
  --name wiremock \
  -v $PWD:/home/wiremock \
  wiremock/wiremock:2.35.0
```

See [https://wiremock.org/docs/standalone/docker/](https://wiremock.org/docs/standalone/docker/) for general details on running WireMock Docker.


## Java / JUnit

If you're running WireMock embedded in a Java program or test suite you can place the JSON file in a folder called `mappings` then set its parent as the WireMock server's root at startup e.g.

```java
WireMockServer wm =
  new WireMockServer(wireMockConfig()
    .withRootDirectory("path/to/root") // The parent folder of mappings
  );
```

See [https://wiremock.org/docs/java-usage/](https://wiremock.org/docs/java-usage/) for general details on running WireMock in embedded Java.


To do the same thing using the JUnit Jupiter extension:

```java
@RegisterExtension
    static WireMockExtension wm1 = WireMockExtension.newInstance()
            .options(wireMockConfig().withRootDirectory("path/to/root"))
            .build();
```

See [https://wiremock.org/docs/junit-jupiter/](https://wiremock.org/docs/junit-jupiter/) for general details on running WireMock with JUnit 5+ Jupiter.

## Pushing to a remotely running WireMock server

The mock API JSON can be pushed to a remotely running WireMock server via its API.

For instance if the WireMock server is running on `wiremock.dev.mycompany.com` port 8080, you can POST the JSON file to it e.g.

```bash
curl -v -d@mockapi.json http://wiremock.dev.mycompany.com:8080/__admin/mappings/import
```