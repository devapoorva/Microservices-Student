FROM maven:3.9.3-eclipse-temurin-17 AS builder
LABEL AUTHOR="Apoorva Raj"
COPY discovery-server/pom.xml /build/
COPY discovery-server/src /build/src/
WORKDIR /build/
RUN mvn package

FROM --platform=linux/x86_64 openjdk:17-alpine
WORKDIR /application
COPY --from=builder /build/ /application/
COPY --from=builder /build/target/DiscoveryServer.jar /application/
ENTRYPOINT [ "java","-jar","-Dspring.profiles.active=docker","DiscoveryServer.jar" ]
