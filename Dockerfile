# === Build Stage ===
FROM maven:3.8.7-openjdk-17 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

# === Runtime Stage ===
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/test-spring-0.0.1-SNAPSHOT.jar ./app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
