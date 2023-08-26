FROM --platform=linux/x86_64 maven:3.9.3-eclipse-temurin-17 AS builder
COPY student-service/pom.xml /build/
COPY student-service/src /build/src/
WORKDIR /build/
RUN mvn install -U -Dmaven.test.failure.ignore=true

FROM --platform=linux/x86_64 openjdk:17-alpine
WORKDIR /application
COPY --from=builder /build/ /application/
COPY --from=builder /build/target/StudentService.jar /application/
ENTRYPOINT [ "java","-jar","-Dspring.profiles.active=docker","StudentService.jar" ]
