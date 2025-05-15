# Use the official Maven image to build the app
FROM maven:3.8.1-openjdk-17-slim as build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and dependencies to the container
COPY pom.xml .

# Download the dependencies
RUN mvn dependency:go-offline

# Copy the entire project
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use OpenJDK 11 as a base image to run the app
FROM openjdk:17-slim

# Copy the built JAR file from the previous image
COPY --from=build /app/target/test-spring-0.0.1-SNAPSHOT.jar /app/test-spring.jar

# Expose the port the app will run on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "/app/test-spring.jar"]
