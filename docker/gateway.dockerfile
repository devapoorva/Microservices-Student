FROM --platform=linux/x86_64 maven:3.9.3-eclipse-temurin-17 AS builder
COPY api-gateway/pom.xml /build/
COPY api-gateway/src /build/src/
WORKDIR /build/
RUN mvn package

FROM --platform=linux/x86_64 openjdk:17-alpine
WORKDIR /application
COPY --from=builder /build/ /application/
COPY --from=builder /build/target/ApiGateway.jar /application/
ENTRYPOINT [ "java","-jar","-Dspring.profiles.active=docker","ApiGateway.jar" ]
