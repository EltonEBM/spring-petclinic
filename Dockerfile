# Use a base image with JDK 17
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the entire target directory to the working directory in the container
COPY target/ /app/

# Expose the port the application will run on
EXPOSE 8080

# Run the Spring Boot application using the exec form of CMD
CMD ["java", "-jar", "target/*"]
