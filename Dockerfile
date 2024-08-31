# Use a base image with JDK 17 (or your required JDK version)
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the jar file from the local system to the working directory in the container
COPY target/spring-petclinic.jar /app/spring-petclinic.jar

# Expose the port the application will run on
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
