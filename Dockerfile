# ==========================================================
# STEP 1: Build Stage — Use Maven to build the JAR
# ==========================================================
FROM maven:3.9.6-eclipse-temurin-21 AS build

# Set working directory inside the container
WORKDIR /app

# Copy pom.xml first and download dependencies (cached layer)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy the source code
COPY src ./src

# Build the Spring Boot application
RUN mvn clean package -DskipTests

# ==========================================================
# STEP 2: Runtime Stage — Use a lightweight JDK image
# ==========================================================
FROM eclipse-temurin:21-jdk-alpine

# Set working directory inside the container
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Environment variables (read from docker-compose or env)
ENV SPRING_PROFILES_ACTIVE=prod

# Start the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
