FROM maven:3.6-jdk-8-slim as BUILD
COPY . /src
WORKDIR /src
RUN mvn install -DskipTests

FROM openjdk:8-jdk-alpine
EXPOSE 8082
WORKDIR /app
ARG JAR=cicd-demo-app-1.0.0-SNAPSHOT.jar

COPY --from=BUILD /src/target/$JAR /app.jar
ENTRYPOINT ["java","-jar","/app.jar"]
