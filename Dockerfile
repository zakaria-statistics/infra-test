# === Build Stage ===
FROM maven:3.8.1-eclipse-temurin-17 AS build

WORKDIR /app

# Copy only pom.xml first to cache dependencies
COPY pom.xml .

RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

RUN mvn clean package -DskipTests

# === Runtime Stage ===
FROM eclipse-temurin:17-jre

WORKDIR /app

COPY --from=build /app/target/test-spring-0.0.1-SNAPSHOT.jar ./app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
